using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Mvc;
using MvcPetVet.Models;
using MvcPetVet.Repositories;
using MvcPetVet.Filters;
using MvcPetVet.Helpers;
using System.Globalization;

namespace MvcPetVet.Controllers
{
	public class UsuariosController : Controller
	{
		private RepositoryUsuarios repo;
        private HelperPathProvider helperPath;
		private HelperClaims helperClaims;

		public UsuariosController(RepositoryUsuarios repo, HelperPathProvider helperPath, HelperClaims helperClaims)
		{
			this.repo = repo;
            this.helperPath = helperPath;
			this.helperClaims = helperClaims;
        }

		[AuthorizeUsers]
		public IActionResult Home()
		{
			return View();
		}

        #region LOG/REGISTER
        public IActionResult Register()
		{
			return View();
		}

		[HttpPost]
		public async Task<IActionResult> Register
			(string apodo, string email, string password)
		{
			await this.repo.RegisterUser(apodo, email, password);
			ViewData["REGISTER"] = "Usuario registrado correctamente";
			return View();
		}

		public IActionResult Login()
		{
			return View();
		}

		[HttpPost]
		public async Task<IActionResult> Login
			(string username, string password)
		{
			Usuario usuario =
				await this.repo.ExisteUsuario(username, password);

			if (usuario != null)
			{
				this.helperClaims.GetClaims(usuario);
				return RedirectToAction("Home", "Usuarios");
			}
			else
			{
				ViewData["MENSAJE"] = "Usuario/Password incorrectos";
				return View();
			}
		}

		public async Task<IActionResult> LogOut()
		{
			await HttpContext.SignOutAsync
				(CookieAuthenticationDefaults.AuthenticationScheme);
			return RedirectToAction("Index", "Home");

		}

        #endregion

        #region ZONAUSUARIO

        [AuthorizeUsers]
		public async Task<IActionResult> UserZone(int idusuario)
		{
			List<Mascota> mascotas = this.repo.GetMascotas(idusuario);
			return View(mascotas);
		}

		[AuthorizeUsers]
		[HttpPost]
		public async Task<IActionResult> UserZone(int idusuario, string nombre, string apodo, 
			string email, string telefono, IFormFile? fichero)
		{
            
			if(fichero != null)
			{
                string fileName = fichero.FileName;

                string path = this.helperPath.MapPath(fileName, Folders.Usuarios);
                using (Stream stream = new FileStream(path, FileMode.Create))
                {
                    await fichero.CopyToAsync(stream);
                }
                Usuario user = await this.repo.UpdateUsuario(idusuario, nombre, apodo,
					email, telefono, fileName);

				this.helperClaims.GetClaims(user);


				ViewData["MENSAJE"] = "CAMBIOS EFECTUADOS CORRECTAMENTE";
                return View(user);
            } else
			{
                Usuario user = await this.repo.UpdateUsuario(idusuario, nombre, apodo,
                    email, telefono);

				this.helperClaims.GetClaims(user);

				ViewData["MENSAJE"] = "CAMBIOS EFECTUADOS CORRECTAMENTE";
                return View(user);
            }

        }


        [AuthorizeUsers]
        public async Task<IActionResult> EditPet(int idmascota)
		{
			Mascota mascota = await this.repo.FindPetAsync(idmascota);
			return View(mascota);
		}

        [AuthorizeUsers]
        [HttpPost]
        public async Task<IActionResult> EditPet(int idusuario, int idmascota, string nombre, string raza,
            string tipo, int peso, DateTime fechanacimiento, IFormFile? fichero)
        {

            if (fichero != null)
            {
                string fileName = fichero.FileName;

                string path = this.helperPath.MapPath(fileName, Folders.Mascotas);
                using (Stream stream = new FileStream(path, FileMode.Create))
                {
                    await fichero.CopyToAsync(stream);
                }
                Mascota pet = await this.repo.UpdateMascota(idusuario, idmascota, nombre, raza,
                    tipo, peso, fechanacimiento, fileName);


                ViewData["MENSAJE"] = "CAMBIOS EFECTUADOS CORRECTAMENTE";
                return View(pet);
            }
            else
            {
                Mascota pet = await this.repo.UpdateMascota(idusuario, idmascota, nombre, raza,
                    tipo, peso, fechanacimiento);

                ViewData["MENSAJE"] = "CAMBIOS EFECTUADOS CORRECTAMENTE";
                return View(pet);
            }

        }


        [AuthorizeUsers]
        public IActionResult Calendar(int idusuario)
        {
			List<Evento> eventos = this.repo.GetEventos(idusuario);
            ViewData["EVENTOS"] = HelperJson.SerializeObject<List<Evento>>(eventos);
            return View();

        }

        public IActionResult PedirCita(int idusuario)
        {
            List<Mascota> mascotas = this.repo.GetMascotas(idusuario);
            ViewData["MASCOTAS"] = new List<Mascota>(mascotas);

            List<Cita> citas = this.repo.GetCitas() ;
            ViewData["CITAS"] = HelperJson.SerializeObject<List<Cita>>(citas);

            return View();
        }

        [HttpPost]
        public async Task<IActionResult> PedirCita(int idusuario, int idmascota, string tipo, string fecha, string hora)
        {
            string dateTimeString = fecha + " " + hora + ":00.00";
            DateTime citaDateTime = DateTime.ParseExact(dateTimeString, "yyyy-MM-dd HH:mm:ss.ff", CultureInfo.InvariantCulture);

            await this.repo.CreateCita(idusuario, idmascota, tipo, citaDateTime);

            List<Mascota> mascotas = this.repo.GetMascotas(idusuario);
            ViewData["MASCOTAS"] = new List<Mascota>(mascotas);

            List<Cita> citas = this.repo.GetCitas();
            ViewData["CITAS"] = HelperJson.SerializeObject<List<Cita>>(citas);

            ViewData["MENSAJE"] = "Cita solicitada Correctamente";
            ViewData["FECHA"] = citaDateTime;
            return View();
        }

        [AuthorizeUsers]
		public IActionResult Tratamientos(int idusuario)
		{
            List<Tratamiento> tratamientos = this.repo.GetTratamientos(idusuario);
            return View(tratamientos);
        }

        [AuthorizeUsers]
        public async Task<IActionResult> Vacunas(int? posicion, int idusuario)
        {
            if (posicion == null)
            {
                posicion = 1;
            }

            List<Vacuna> vacunas = await this.repo.GetVacunasPaginar(posicion.Value, idusuario);
            ViewData["REGISTROS"] = this.repo.GetNumeroVacunas(idusuario);
            return View(vacunas);
        }

        [AuthorizeUsers]
        public  IActionResult Pruebas( int idusuario)
        {
            List<Prueba> pruebas = this.repo.GetPruebas(idusuario);
            return View(pruebas);
        }

        [AuthorizeUsers]
        public async Task<IActionResult> HistorialVeterinario(int? posicion, int idusuario)
        {
            if (posicion == null)
            {
                posicion = 1;
            }

            List<Procedimiento> procedimientos = await this.repo.GetProcedimientosPaginar(posicion.Value, idusuario);
            ViewData["REGISTROS"] = this.repo.GetNumeroProcedimientos(idusuario);
            return View(procedimientos);
        }

        #endregion

        public IActionResult FAQs()
        {
            List<FAQ> faqs = this.repo.GetFAQs();
            return View(faqs);
        }
    }
}
