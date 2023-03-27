using Microsoft.AspNetCore.Mvc;
using MvcPetVet.Models;
using MvcPetVet.Repositories;

namespace MvcPetVet.Controllers
{
    public class HomeController : Controller
    {
        private RepositoryUsuarios repo;

        public HomeController(RepositoryUsuarios repo)
        {
            this.repo = repo;
        }

        public IActionResult Index()
        {
            return View();
        }

        public IActionResult Servicios()
        {
            List<Servicio> servicios = this.repo.GetServicios();
            return View(servicios);
        }
    }
}
