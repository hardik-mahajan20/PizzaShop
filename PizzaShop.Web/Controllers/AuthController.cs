using Microsoft.AspNetCore.Mvc;
using PizzaShop.Service.Interfaces;
namespace PizzaShop.Web.Controllers;

public class AuthController : Controller
{
    private readonly IAuthService _authService;
    public AuthController(IAuthService authService)
    {
        _authService = authService;
    }
    [HttpPost]
    public async Task<IActionResult> Login(string email, string password)
    {
        await _authService.LoginAsync(email, password);
        return RedirectToAction("Index", "Dashboard");
    }
    [HttpGet]
    public IActionResult Login()
    {
        return View();
    }

}
