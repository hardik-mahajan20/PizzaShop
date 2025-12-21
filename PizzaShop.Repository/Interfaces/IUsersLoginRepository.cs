using PizzaShop.Repository.Models;

namespace PizzaShop.Repository.Interfaces;

public interface IUsersLoginRepository
{
    Task<User?> GetByEmailAsync(string email);
}
