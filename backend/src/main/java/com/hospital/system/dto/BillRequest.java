package com.hospital.system.dto; import jakarta.validation.constraints.*; public class BillRequest { @NotNull public Long patientId; public Long appointmentId; }
