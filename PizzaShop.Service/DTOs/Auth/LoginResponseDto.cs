namespace PizzaShop.Service.DTOs.Auth;

public class LoginResponseDto
{
    public string? Email { get; set; }
    public string? PasswordHash { get; set; }
}
