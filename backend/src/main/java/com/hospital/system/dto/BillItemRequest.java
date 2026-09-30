package com.hospital.system.dto; import jakarta.validation.constraints.*; public class BillItemRequest { @NotNull public Long serviceId; @NotNull @Positive public Integer quantity; }
