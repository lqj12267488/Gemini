package com.goisan.educational.skill.dao;

import com.goisan.educational.skill.bean.Skill;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SkillDao {
    List<Skill> skillAction(Skill skill);
    void deleteSkillById(String id);
    Skill getSkillById(String id);
    void updateSkillById(Skill skill);
    void insertSkill(Skill skill);
}
