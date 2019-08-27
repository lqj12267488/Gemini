package com.goisan.educational.skill.service.impl;

import com.goisan.educational.skill.bean.Skill;
import com.goisan.educational.skill.dao.SkillDao;
import com.goisan.educational.skill.service.SkillService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class SkillServiceImpl implements SkillService{
    @Resource
    private SkillDao skillDao;
    public List<Skill> skillAction(Skill skill){
        return skillDao.skillAction(skill);
    }
    public void deleteSkillById(String id){
        skillDao.deleteSkillById(id);
    }
    public Skill getSkillById(String id){
        return skillDao.getSkillById(id);
    }
    public void updateSkillById(Skill skill){
        skillDao.updateSkillById(skill);
    }
    public void insertSkill(Skill skill){
        skillDao.insertSkill(skill);
    }
}
