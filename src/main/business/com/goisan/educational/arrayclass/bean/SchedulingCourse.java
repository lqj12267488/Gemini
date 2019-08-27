package com.goisan.educational.arrayclass.bean;


import java.util.*;

public class SchedulingCourse {

    private List<ArrayclassArray> classes;
    private Map<String, ArrayclassResultClass>[] schedulingCourse;
    private Map<String, List<String>> teacherTeachCourseId;
    private Random r = null;
    private int dayHoursTotal;
    private int dayTotal;
    private Map<Integer, String> indexToCode = new HashMap<Integer, String>();


    public SchedulingCourse(ArrayClass arrayClass, List<ArrayclassResultClass>
            arrayclassResultClasses, List<ArrayClassTeacherCourse> arrayClassTeacherCourses,
                            List<ArrayclassArray> arrayclassArrays) {
        this.r = new Random(dayTotal * dayHoursTotal);
        this.classes = arrayclassArrays;
        this.dayTotal = Integer.parseInt(arrayClass.getWeeks());
        this.dayHoursTotal = (Integer.parseInt(arrayClass
                .getMorningHours()) + Integer.parseInt(arrayClass.getForenoonHours()) + Integer
                .parseInt(arrayClass.getNoonHours()) + Integer.parseInt(arrayClass
                .getAfternoonHours()) + Integer.parseInt(arrayClass.getEveningHours()));
        this.schedulingCourse = new Map[dayTotal * dayHoursTotal];
        this.teacherTeachCourseId = new HashMap<String, List<String>>();
        initIndexToCode(arrayClass);
        for (ArrayClassTeacherCourse arrayClassTeacherCourse : arrayClassTeacherCourses) {
            List<String> courseIds = teacherTeachCourseId.get(arrayClassTeacherCourse
                    .getTeacherPersonId());
            if (courseIds != null) {
                courseIds.add(arrayClassTeacherCourse.getCourseId());
            } else {
                courseIds = new ArrayList<String>();
                courseIds.add(arrayClassTeacherCourse.getCourseId());
                teacherTeachCourseId.put(arrayClassTeacherCourse.getTeacherPersonId(), courseIds);
            }
        }
        for (int i = 0; i < arrayclassResultClasses.size(); i++) {
            int index = weekToIndex(arrayclassResultClasses.get(i));
            if (schedulingCourse[index] == null) {
                schedulingCourse[index] = new HashMap<String, ArrayclassResultClass>();
            }
            schedulingCourse[index].put(arrayclassResultClasses.get(i).getClassId(),
                    arrayclassResultClasses.get(i));
            arrayclassResultClasses.remove(i);
        }
    }

    public Map[] getSchedulingCourse() {
        for (int i = 0; i < 10; i++) {
            for (ArrayclassArray aClass : classes) {
                pk(aClass);
            }
        }
        return schedulingCourse;
    }


    private int weekToIndex(ArrayclassResultClass rc) {
        int index = 0;
        Set<Map.Entry<Integer, String>> entries = indexToCode.entrySet();
        for (Map.Entry<Integer, String> map : entries) {
            if (map.getValue().equals(rc.getHoursCode())) {
                index = map.getKey() * Integer.parseInt(rc.getWeek());
            }
        }
        return index;
    }

    private void pk(ArrayclassArray c) {
        boolean flag = true;
        while (flag) {
            int i = r.nextInt(dayTotal * dayHoursTotal);
            if (checkWerkHours(c)) {
                Map<String, ArrayclassResultClass> data = schedulingCourse[i];
                if (data == null && getIndexs(i, c) != null) {
                    addSchedulingCourse(getIndexs(i, c), c);
                    flag = false;
                } else {
                    if (checkAll(i, c) && getIndexs(i, c) != null) {
                        addSchedulingCourse(getIndexs(i, c), c);
                        flag = false;
                    }
                }
            } else {
                flag = false;
            }
        }
    }

    private void initIndexToCode(ArrayClass arrayClass) {
        int j = 0, k = 0;
        String[] strs = new String[]{"MORNING_HOURS", "FORENOON_HOURS", "NOON_HOURS",
                "AFTERNOON_HOURS", "EVENING_HOURS"};
        for (int i = 0; i < dayHoursTotal; i++) {
            if (strs[k].equals("MORNING_HOURS")) {
                if (arrayClass.getMorningHours() != null && j < Integer.parseInt(arrayClass
                        .getMorningHours())) {
                    indexToCode.put(i, "1" + (++j));
                } else {
                    j = 0;
                    k++;
                }
            }
            if (strs[k].equals("FORENOON_HOURS")) {
                if (arrayClass.getForenoonHours() != null && j < Integer.parseInt(arrayClass
                        .getForenoonHours())) {
                    indexToCode.put(i, "2" + (++j));
                } else {
                    j = 0;
                    k++;
                }
            }
            if (strs[k].equals("NOON_HOURS")) {
                if (arrayClass.getNoonHours() != null && j < Integer.parseInt(arrayClass
                        .getNoonHours())) {
                    indexToCode.put(i, "3" + (++j));
                } else {
                    j = 0;
                    k++;
                }
            }
            if (strs[k].equals("AFTERNOON_HOURS")) {
                if (arrayClass.getAfternoonHours() != null && j < Integer.parseInt(arrayClass
                        .getAfternoonHours())) {
                    indexToCode.put(i, "4" + (++j));
                } else {
                    j = 0;
                    k++;
                }
            }
            if (strs[k].equals("EVENING_HOURS")) {
                if (arrayClass.getEveningHours() != null && j < Integer.parseInt(arrayClass
                        .getEveningHours())) {
                    indexToCode.put(i, "5" + (++j));
                } else {
                    j = 0;
                    k++;
                }
            }
        }
    }

    private boolean checkAll(int i, ArrayclassArray c) {
        Map<String, ArrayclassResultClass> map = schedulingCourse[i];
        boolean b = false;
        if (map != null) {
            Collection<ArrayclassResultClass> arrays = map.values();
            for (ArrayclassResultClass a : arrays) {
                if (check(a, c)) {
                    b = true;
                }
            }
        }
        return b;

    }

    private boolean check(ArrayclassResultClass a, ArrayclassArray b) {
        return checkTecaher(a, b) && checkClassRoom(a, b) && checkClassId(a, b);
    }

    private boolean checkClassId(ArrayclassResultClass a, ArrayclassArray b) {
        return !a.getClassId().equals(b.getClassId());
    }

    private boolean checkTecaher(ArrayclassResultClass a, ArrayclassArray b) {
        boolean flag = true;
        if (a.getTeacherPersonId().equals(b.getTeacherPersonId())) {
            flag = false;
        } else {
            List<String> list = teacherTeachCourseId.get(b.getTeacherPersonId());
            if (list != null) {
                for (String str : list) {
                    if (str.equals(b.getCourseId())) {
                        flag = false;
                        break;
                    }
                }
            }
        }
        return flag;
    }

    private boolean checkClassRoom(ArrayclassResultClass a, ArrayclassArray b) {
        return !a.getRoomId().equals(b.getRoomId());
    }

    private boolean checkWerkHours(ArrayclassArray c) {
        int j = 0;
        for (int i = 0; i < schedulingCourse.length; i++) {
            if (schedulingCourse[i] != null) {
                ArrayclassResultClass array = schedulingCourse[i].get(c.getClassId());
                if (array != null && array.getCourseId().equals(c.getCourseId())) {
                    j++;
                    if (Integer.parseInt(c.getWeekHours()) == j) {
                        return false;
                    }
                }
            }
        }
        return Integer.parseInt(c.getWeekHours()) > j;
    }


    private int[] getIndexs(int i, ArrayclassArray c) {
        int[] indexs = new int[Integer.parseInt(c.getConnectHours())];
        indexs[0] = i;
        for (int j = 1; j < indexs.length; j++) {
            int k = ++i;
            if (k < dayTotal * dayHoursTotal) {
                if (k % 2 == 0 && k - 2 > 0) {
                    indexs[j] = k - 2;
                } else {
                    indexs[j] = k;
                }
            } else {
                indexs = null;
                break;
            }
        }
        return indexs;
    }

    private void addSchedulingCourse(int[] indexs, ArrayclassArray rc) {
        for (int i : indexs) {
            ArrayclassResultClass arrayclassResultClass = new ArrayclassResultClass();
            arrayclassResultClass.setArrayclassId(rc.getArrayclassId());
            arrayclassResultClass.setArrayId(rc.getArrayId());
            arrayclassResultClass.setWeek(rc.getWeekType());
            arrayclassResultClass.setCourseId(rc.getCourseId());
            arrayclassResultClass.setStartWeek(rc.getStartWeek());
            arrayclassResultClass.setHoursType(indexToCode.get(i % dayHoursTotal).substring(0, 1));
            arrayclassResultClass.setEndWeek(rc.getEndWeek());
            arrayclassResultClass.setTeacherPersonId(rc.getTeacherPersonId());
            arrayclassResultClass.setTeacherDeptId(rc.getTeacherDeptId());
            arrayclassResultClass.setClassId(rc.getClassId());
            arrayclassResultClass.setCourseType(rc.getCourseType());
            arrayclassResultClass.setWeek(String.valueOf(i / dayHoursTotal + 1));
            arrayclassResultClass.setHoursCode(indexToCode.get(i % dayHoursTotal));
            arrayclassResultClass.setArrayclassFlag("1");
            arrayclassResultClass.setRoomId(rc.getRoomId());
            arrayclassResultClass.setMajorCode(rc.getMajorCode());
            arrayclassResultClass.setMajorDirection(rc.getMajorDirection());
            arrayclassResultClass.setTrainingLevel(rc.getTrainingLevel());
            arrayclassResultClass.setDepartmentsId(rc.getDepartmentsId());
            if (schedulingCourse[i] == null) {
                schedulingCourse[i] = new HashMap<String, ArrayclassResultClass>();
            }
            schedulingCourse[i].put(rc.getClassId(), arrayclassResultClass);
        }
    }

}
