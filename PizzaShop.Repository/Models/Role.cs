using System;
using System.Collections.Generic;

namespace PizzaShop.Repository.Models;

public partial class Role
{
    public int RoleId { get; set; }

    public string RoleName { get; set; } = null!;

    public virtual ICollection<Permission> Permissions { get; } = new List<Permission>();

    public virtual ICollection<User> Users { get; } = new List<User>();

    public virtual ICollection<UsersLogin> UsersLogins { get; } = new List<UsersLogin>();
}
