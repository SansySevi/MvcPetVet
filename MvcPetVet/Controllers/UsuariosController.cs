using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Mvc;
using MvcPetVet.Models;
using MvcPetVet.Repositories;
using System.Security.Claims;
using MvcCoreSeguridadPersonalizada.Filters;
using MvcCoreUtilidades.Helpers;

namespace MvcPetVet.Controllers
{
	public class UsuariosController : Controller
	{
		private RepositoryUsuarios repo;
        private HelperPathProvider helperPath;

        public UsuariosController(RepositoryUsuarios repo, HelperPathProvider helperPath)
		{
			this.repo = repo;
            this.helperPath = helperPath;
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
				ClaimsIdentity identity =
					new ClaimsIdentity
					(CookieAuthenticationDefaults.AuthenticationScheme,
					ClaimTypes.Name, ClaimTypes.Role);

				Claim ClaimName = new Claim(ClaimTypes.Name, usuario.Apodo.ToString());
				identity.AddClaim(ClaimName);

				Claim ClaimId = new Claim(ClaimTypes.NameIdentifier
					, usuario.IdUsuario.ToString());
				identity.AddClaim(ClaimId);

				Claim claimImagen =
					new Claim("Imagen", usuario.Imagen.ToString());
				identity.AddClaim(claimImagen);

                Claim claimEmail =
                    new Claim("Email", usuario.Email.ToString());
                identity.AddClaim(claimEmail);

                Claim claimRole =
					new Claim(ClaimTypes.Role, "Usuario");
				identity.AddClaim(claimRole);

				ClaimsPrincipal userPrincipal =
					new ClaimsPrincipal(identity);
				await HttpContext.SignInAsync(
					CookieAuthenticationDefaults.AuthenticationScheme
					, userPrincipal);
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
			Usuario user = await this.repo.FindUserAsync(idusuario);
			return View(user);
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
                ViewData["MENSAJE"] = "CAMBIOS EFECTUADOS CORRECTaMENTE";
                return View(user);
            } else
			{
                Usuario user = await this.repo.UpdateUsuario(idusuario, nombre, apodo,
                    email, telefono);
                ViewData["MENSAJE"] = "CAMBIOS EFECTUADOS CORRECTAMENTE";
                return View(user);
            }

        }


		[AuthorizeUsers]
		public IActionResult Tratamientos(int idusuario)
		{
			return View();
		}

		[AuthorizeUsers]
		public IActionResult HistorialVeterinario(int idusuario)
		{
			return View();
		}
	}
}
