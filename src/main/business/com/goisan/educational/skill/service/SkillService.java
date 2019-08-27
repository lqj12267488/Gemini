package com.goisan.educational.skill.service;

import com.goisan.educational.skill.bean.Skill;

import java.util.List;

public interface SkillService {
    List<Skill> skillAction(Skill skill);
    void deleteSkillById(String id);
    Skill getSkillById(String id);
    void updateSkillById(Skill skill);
    void insertSkill(Skill skill);
}
