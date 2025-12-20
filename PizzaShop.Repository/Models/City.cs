using System;
using System.Collections.Generic;

namespace PizzaShop.Repository.Models;

public partial class City
{
    public int CityId { get; set; }

    public string CityName { get; set; } = null!;

    public int StateId { get; set; }

    public DateTime? CreatedAt { get; set; }

    public int CreatedBy { get; set; }

    public DateTime? ModifiedAt { get; set; }

    public int? ModifiedBy { get; set; }

    public virtual State State { get; set; } = null!;

    public virtual ICollection<User> Users { get; } = new List<User>();
}
