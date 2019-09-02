package com.goisan.studentwork.graduatearchivesaddress.service;

import com.goisan.studentwork.graduatearchivesaddress.bean.Arcad;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created  By hanjie ON 2019/8/29
 */
@Repository
public interface ArcadServcie {
    List<Arcad> getArcadList(Arcad arcad);
    Arcad getArcadById(String arcadId);
    void insertArcad(Arcad arcad);
    void updateArcadById(Arcad arcad);
    void delArcadById(Arcad arcad);


    List<String> findProvince();

    List<String> findCity(String str);
    List<String> findCity1(String str);

    List<String> findCounty(String str);

    List<String> find(String str);

    List<String> findCounty1(String str);

    List<String> findAllCity();

    List<String> findCityOrCounty();

    List<String> select(String str);

    List<String> findBj();

    List<String> findTj();

    List<String> findSh();

    List<String> findCq();
}
