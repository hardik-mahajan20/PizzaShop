using Microsoft.AspNetCore.Mvc;

namespace PizzaShop.Web.Controllers;

public class DashboardController : Controller
{
    [HttpGet]
    public IActionResult Index()
    {
        return View();
    }
}
