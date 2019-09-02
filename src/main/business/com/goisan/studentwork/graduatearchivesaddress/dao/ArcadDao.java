package com.goisan.studentwork.graduatearchivesaddress.dao;

import com.goisan.studentwork.graduatearchivesaddress.bean.Arcad;
import org.apache.ibatis.annotations.Select;
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
    @Select("select name from T_SYS_ADMINISTRATIVE_DIVISIONS where type = '1'")
    List<String> findProvince();

    @Select("select name from T_SYS_ADMINISTRATIVE_DIVISIONS t where type = '2' and PARENT_ID = (select id from T_SYS_ADMINISTRATIVE_DIVISIONS where name = #{str})")
    List<String> findCity(String str);

    @Select("select name from T_SYS_ADMINISTRATIVE_DIVISIONS t where type = '3' and PARENT_ID = (select id from T_SYS_ADMINISTRATIVE_DIVISIONS where name = #{str})")
    List<String> findCounty(String str);

    @Select("select id from T_SYS_ADMINISTRATIVE_DIVISIONS where name = #{str}")
    List<String> find(String str);

    @Select("select name from T_SYS_ADMINISTRATIVE_DIVISIONS t where type = '3' and PARENT_ID = #{str}")
    List<String> findCounty1(String str);

    @Select("select name from T_SYS_ADMINISTRATIVE_DIVISIONS where type = '2'")
    List<String> findAllCity();

    @Select("select name from T_SYS_ADMINISTRATIVE_DIVISIONS t where type = '2' and PARENT_ID = #{str}")
    List<String> findCity1(String str);


    List<String> findCityOrCounty();

    @Select("select id from T_SYS_ADMINISTRATIVE_DIVISIONS where name = #{str}")
    List<String> select(String str);

    @Select("SELECT name  FROM t_sys_administrative_divisions WHERE valid_flag = '1' and type = '3' and parent_id ='110100'")
    List<String> findBj();

    @Select("SELECT  name  FROM t_sys_administrative_divisions WHERE valid_flag = '1' and type = '3' and parent_id ='120100' ")
    List<String> findTj();

    @Select("SELECT  name  FROM t_sys_administrative_divisions WHERE valid_flag = '1' and type = '3' and parent_id ='310100' ")
    List<String> findSh();

    @Select("SELECT name  FROM t_sys_administrative_divisions WHERE valid_flag = '1' and type = '3' and parent_id ='500100' ")
    List<String> findCq();
}
