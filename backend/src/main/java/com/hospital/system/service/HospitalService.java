package com.hospital.system.service;

import com.hospital.system.exception.ApiException;
import com.hospital.system.repository.ServiceRepository;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class HospitalService {

    private final ServiceRepository repository;

    public HospitalService(ServiceRepository repository) {
        this.repository = repository;
    }

    public List<com.hospital.system.model.HospitalService> all() {
        return repository.all();
    }

    public com.hospital.system.model.HospitalService one(Long id) {
        return repository.one(id)
                .orElseThrow(() ->
                        new ApiException(HttpStatus.NOT_FOUND, "Service not found"));
    }

    public com.hospital.system.model.HospitalService add(
            com.hospital.system.model.HospitalService service) {

        if (service.price == null || service.price.signum() < 0) {
            throw new ApiException(
                    HttpStatus.BAD_REQUEST,
                    "Price must be non-negative"
            );
        }

        repository.add(service);

        return repository.all()
                .stream()
                .filter(s -> s.serviceName.equals(service.serviceName))
                .findFirst()
                .orElseThrow(() ->
                        new ApiException(
                                HttpStatus.INTERNAL_SERVER_ERROR,
                                "Service could not be created"
                        ));
    }

    public com.hospital.system.model.HospitalService update(
            Long id,
            com.hospital.system.model.HospitalService service) {

        one(id);

        if (service.price == null || service.price.signum() < 0) {
            throw new ApiException(
                    HttpStatus.BAD_REQUEST,
                    "Price must be non-negative"
            );
        }

        repository.update(id, service);

        return one(id);
    }

    public void delete(Long id) {
        one(id);
        repository.delete(id);
    }
}