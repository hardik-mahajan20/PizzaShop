using PizzaShop.Service.DTOs.Auth;

namespace PizzaShop.Service.Interfaces;

public interface IAuthService
{
    Task<LoginResponseDto?> LoginAsync(string email, string password);
}
