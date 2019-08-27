package com.goisan.practice.dao;

import com.goisan.practice.bean.Material;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MaterialDao {
    List<Material> materialAction(Material material);

    void deleteMaterialById(String id);

    Material getMaterialById(String id);

    void updateMaterialById(Material material);

    void insertMaterial(Material material);
}
