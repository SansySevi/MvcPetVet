using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Mvc;
using MvcPetVet.Models;
using MvcPetVet.Repositories;
using MvcPetVet.Filters;
using MvcPetVet.Helpers;

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

		[AuthorizeUsers]
		public IActionResult Home2()
		{
			return View();
		}

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

		[AuthorizeUsers]
		public IActionResult DatesCalendar()
		{
			List<Cita> citas = this.repo.GetCitas(1);
			return View();
		}

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
		public IActionResult Tratamientos(int idusuario)
		{
            List<Tratamiento> tratamientos = this.repo.GetTratamientos(idusuario);
            return View(tratamientos);
        }

		[AuthorizeUsers]
		public IActionResult HistorialVeterinario(int idusuario)
		{
			return View();
		}
	}
}
