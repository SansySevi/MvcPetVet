using Microsoft.AspNetCore.Mvc;
using MvcPetVet.Models;
using MvcPetVet.Repositories;

namespace MvcPetVet.Controllers
{
    public class UsuariosController : Controller
    {
        private RepositoryUsuarios repo;

        public UsuariosController(RepositoryUsuarios repo)
        {
            this.repo = repo;
        }

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
        public IActionResult Login(string log, string password)
        {

            Usuario user = this.repo.LogInUser(log, password);
            if (user == null)
            {
                ViewData["MENSAJE"] = "Credenciales incorrectas";
                return View();
            }
            else
            {
                return RedirectToAction("Home");
            }
        }

        public IActionResult DatesCalendar()
        {
            List<Cita> citas = this.repo.GetCitas(1);
            return View();
        }
    }
}
