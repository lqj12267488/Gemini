package com.goisan.educational.score.bean;

import java.util.List;

public class StudentScore {
    private String name;
    private String number;
    private List<ScoreImport> scores;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }

    public List<ScoreImport> getScores() {
        return scores;
    }

    public void setScores(List<ScoreImport> scores) {
        this.scores = scores;
    }
}
