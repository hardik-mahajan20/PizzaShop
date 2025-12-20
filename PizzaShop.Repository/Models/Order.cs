using System;
using System.Collections.Generic;

namespace PizzaShop.Repository.Models;

public partial class Order
{
    public int OrderId { get; set; }

    public DateTime? OrderDate { get; set; }

    public int CustomerId { get; set; }

    public string? PaymentMode { get; set; }

    public string? OrderWiseComment { get; set; }

    public short? NoOfPerson { get; set; }

    public decimal? Rating { get; set; }

    public decimal? SubAmount { get; set; }

    public decimal? Discount { get; set; }

    public decimal? TotalTax { get; set; }

    public decimal TotalAmount { get; set; }

    public int Status { get; set; }

    public string? OrderType { get; set; }

    public string? InvoiceNumber { get; set; }

    public DateTime? CreatedAt { get; set; }

    public int CreatedBy { get; set; }

    public DateTime? ModifiedAt { get; set; }

    public int? ModifiedBy { get; set; }

    public virtual Customer Customer { get; set; } = null!;

    public virtual ICollection<CustomerReview> CustomerReviews { get; } = new List<CustomerReview>();

    public virtual ICollection<Invoice> Invoices { get; } = new List<Invoice>();

    public virtual ICollection<OrderTable> OrderTables { get; } = new List<OrderTable>();

    public virtual ICollection<OrderTaxMapping> OrderTaxMappings { get; } = new List<OrderTaxMapping>();

    public virtual ICollection<OrderedItemModifier> OrderedItemModifiers { get; } = new List<OrderedItemModifier>();

    public virtual ICollection<OrderedItem> OrderedItems { get; } = new List<OrderedItem>();
}
