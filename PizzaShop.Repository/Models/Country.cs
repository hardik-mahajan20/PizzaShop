using System;
using System.Collections.Generic;

namespace PizzaShop.Repository.Models;

public partial class Country
{
    public int CountryId { get; set; }

    public string ShortName { get; set; } = null!;

    public string CountryName { get; set; } = null!;

    public int PhoneCode { get; set; }

    public DateTime? CreatedAt { get; set; }

    public int CreatedBy { get; set; }

    public DateTime? ModifiedAt { get; set; }

    public int? ModifiedBy { get; set; }

    public virtual ICollection<State> States { get; } = new List<State>();

    public virtual ICollection<User> Users { get; } = new List<User>();
}
