using Microsoft.AspNetCore.Mvc;

namespace MvcPetVet.Controllers
{
    public class UsuariosController : Controller
    {
        public IActionResult Login()
        {
            return View();
        }

        public IActionResult Register()
        {
            return View();
        }
    }
}
