using Microsoft.EntityFrameworkCore;
using PizzaShop.Repository.Interfaces;
using PizzaShop.Repository.Models;

namespace PizzaShop.Repository.Implementations;

public class UsersLoginRepository : IUsersLoginRepository
{
    private readonly PizzaShopContext _context;

    public UsersLoginRepository(PizzaShopContext context)
    {
        _context = context;
    }

    public async Task<User?> GetByEmailAsync(string email)
    {
        return await _context.Users.FirstOrDefaultAsync(x => x.Email == email);
    }

}
