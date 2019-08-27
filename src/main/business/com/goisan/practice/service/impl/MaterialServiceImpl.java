package com.goisan.practice.service.impl;

import com.goisan.practice.bean.Material;
import com.goisan.practice.dao.MaterialDao;
import com.goisan.practice.service.MaterialService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class MaterialServiceImpl implements MaterialService{
    @Resource
    private MaterialDao materialDao;

    public List<Material> materialAction(Material material){
        return materialDao.materialAction(material);
    }

    public void deleteMaterialById(String id){
        materialDao.deleteMaterialById(id);
    }

    public Material getMaterialById(String id){
        return materialDao.getMaterialById(id);
    }

    public void updateMaterialById(Material material){
        materialDao.updateMaterialById(material);
    }

    public void insertMaterial(Material material){
        materialDao.insertMaterial(material);
    }

}
