package com.goisan.studentwork.graduatearchivesaddress.dao;

import com.goisan.studentwork.graduatearchivesaddress.bean.Arcad;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created  By hanjie ON 2019/8/29
 */
@Repository
public interface ArcadDao {
    List<Arcad> getArcadList(Arcad arcad);
    Arcad getArcadById(String arcadId);
    void insertArcad(Arcad arcad);
    void updateArcadById(Arcad arcad);
    void delArcadById(Arcad arcad);

}
