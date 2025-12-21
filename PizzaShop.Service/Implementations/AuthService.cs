using PizzaShop.Repository.Interfaces;
using PizzaShop.Repository.Models;
using PizzaShop.Service.DTOs.Auth;
using PizzaShop.Service.Interfaces;

namespace PizzaShop.Service.Implementations;

public class AuthService : IAuthService
{
    private readonly IUsersLoginRepository _usersLoginRepository;
    public AuthService(IUsersLoginRepository usersLoginRepository)
    {
        _usersLoginRepository = usersLoginRepository;
    }

    public async Task<LoginResponseDto?> LoginAsync(string email, string password)
    {
        User? usersLogin = await _usersLoginRepository.GetByEmailAsync(email);

        if (usersLogin == null)
        {
            return null;
        }
        if (usersLogin.PasswordHash != password)
        {
            return null;
        }
        return new LoginResponseDto
        {
            Email = usersLogin.Email!,
            PasswordHash = usersLogin.PasswordHash
        };
    }
}
