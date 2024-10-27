enum OrderStatus { pending, delivered, canceled }

OrderStatus getStatusType(String? status) {
  switch (status) {
    case "Pending (In the courier)":
      return OrderStatus.pending;
    case "Delivered":
      return OrderStatus.delivered;
    default:
      return OrderStatus.canceled;
  }
}
