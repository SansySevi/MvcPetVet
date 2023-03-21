using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Mvc;
using MvcPetVet.Models;
using MvcPetVet.Repositories;
using System.Security.Claims;
using MvcCoreSeguridadPersonalizada.Filters;

namespace MvcPetVet.Controllers
{
	public class UsuariosController : Controller
	{
		private RepositoryUsuarios repo;

		public UsuariosController(RepositoryUsuarios repo)
		{
			this.repo = repo;
		}

		[AuthorizeUsers]
		public IActionResult Home()
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
			ViewData["MENSAJE"] = "Usuario registrado correctamente";
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
			string email, string telefono)
		{

			Usuario user = await this.repo.UpdateUsuario(idusuario, nombre, apodo,
            email, telefono);
            return View(user);
        }
	}
}
