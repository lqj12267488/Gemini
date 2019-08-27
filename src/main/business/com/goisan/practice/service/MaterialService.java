package com.goisan.practice.service;

import com.goisan.practice.bean.Material;

import java.util.List;

public interface MaterialService {
    List<Material> materialAction(Material material);

    void deleteMaterialById(String id);

    Material getMaterialById(String id);

    void updateMaterialById(Material material);

    void insertMaterial(Material material);
}
