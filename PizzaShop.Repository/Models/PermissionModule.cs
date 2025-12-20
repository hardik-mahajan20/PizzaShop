using System;
using System.Collections.Generic;

namespace PizzaShop.Repository.Models;

public partial class PermissionModule
{
    public int ModuleId { get; set; }

    public string ModuleName { get; set; } = null!;

    public virtual ICollection<Permission> Permissions { get; } = new List<Permission>();
}
