using Microsoft.AspNetCore.Mvc;

namespace MvcPetVet.Controllers
{
    public class HomeController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
