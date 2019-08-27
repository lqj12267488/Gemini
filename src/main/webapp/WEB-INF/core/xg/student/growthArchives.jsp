<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <%--<div class="block block-drop-shadow">
                    <div class="header">
                        <button type="button" class="btn btn-default btn-clean" id="back"
                                onclick="back()">返回
                        </button>
                    </div>
                </div>--%>
                <div class="block block-drop-shadow content">
                    <header class="mui-bar mui-bar-nav">
                        <h5 class="mui-title"> ${studentName}</h5>
                    </header>
                    <br>
                    <ul class="nav nav-tabs nav-justified">
                        <li class="active"><a href="#tab9" data-toggle="tab">学生个人信息</a></li>
                        <li><a href="#tab10" data-toggle="tab">个人缴费</a></li>
                        <li><a href="#tab11" data-toggle="tab">学生奖惩</a></li>
                    </ul>
                    <div class="content tab-content">
                        <div class="tab-pane active" id="tab9">
                            <div class="form-row">
                                <div class="col-md-2 tar">
                                    学生姓名
                                </div>
                                <div class="col-md-4">
                                    <input id="name" type="text" readonly value="${student.name}"/>
                                </div>
                                <div class="col-md-2 tar">
                                    性别
                                </div>
                                <div class="col-md-4">
                                    <input id="sex" type="text" readonly value="${student.sexShow}"/>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-md-2 tar" id="idcardAlert">
                                    身份证号
                                </div>
                                <div class="col-md-4">
                                    <input id="idcard" type="text" readonly value="${student.idcard}"/>
                                </div>
                                <div class="col-md-2 tar">
                                    出生日期
                                </div>
                                <div class="col-md-4">
                                    <input id="birth" type="date" readonly value="${student.birthday}"/>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-md-2 tar">
                                    入学年份
                                </div>
                                <div class="col-md-4">
                                    <input id="joinY" type="text" readonly value="${student.joinYear}"/>
                                </div>
                                <div class="col-md-2 tar">
                                    入学月份
                                </div>
                                <div class="col-md-4">
                                    <input id="joinM" type="text" readonly value="${student.joinMonth}"/>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-md-2 tar" id="studentNumberAlert">
                                    学籍号
                                </div>
                                <div class="col-md-4">
                                    <input id="studentNumber" type="text" readonly value="${student.studentNumber}"/>
                                </div>
                                <div class="col-md-2 tar">
                                    学籍状态
                                </div>
                                <div class="col-md-4" id="studentStatusDIV">
                                    <input id="studentStatus" type="text" readonly
                                           value="${student.studentStatusShow}"/>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-md-2 tar">
                                    民族
                                </div>
                                <div class="col-md-4">
                                    <input id="nation" type="text" readonly value="${student.nationShow}"/>
                                </div>
                                <div class="col-md-2 tar">
                                    国籍
                                </div>
                                <div class="col-md-4">
                                    <input id="nationality" type="text" readonly value="${student.nationalityShow}"/>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-md-2 tar">
                                    政治面貌
                                </div>
                                <div class="col-md-4">
                                    <input id="politicalStatus" type="text" readonly
                                           value="${student.politicalStatusShow}"/>
                                </div>
                                <div class="col-md-2 tar">
                                    户籍性质
                                </div>
                                <div class="col-md-4">
                                    <input id="houseType" type="text" readonly
                                           value="${student.householdRegisterTypeShow}"/>
                                </div>
                            </div>

                            <div class="form-row">
                                <div class="col-md-2 tar">
                                    户籍省
                                </div>
                                <div class="col-md-4">
                                    <input id="houseProvince" type="text" readonly
                                           value="${student.houseProvinceShow}"/>
                                </div>
                                <div class="col-md-2 tar">
                                    现家庭所在省
                                </div>
                                <div class="col-md-4">
                                    <input id="nowProvince" type="text" readonly value="${student.addressProvinceShow}"/>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-md-2 tar">
                                    户籍市
                                </div>
                                <div class="col-md-4">
                                    <input id="houseCity" type="text" readonly value="${student.houseCityShow}"/>
                                </div>
                                <div class="col-md-2 tar">
                                    现家庭所在市
                                </div>
                                <div class="col-md-4">
                                    <input id="nowCity" type="text" readonly value="${student.addressCityShow}"/>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-md-2 tar">
                                    户籍县
                                </div>
                                <div class="col-md-4">
                                    <input id="houseCounty" type="text" readonly value="${student.houseCountyShow}"/>
                                </div>
                                <div class="col-md-2 tar">
                                    现家庭所在县
                                </div>
                                <div class="col-md-4">
                                    <input id="nowCounty" type="text" readonly value="${student.addressCountyShow}"/>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-md-2 tar">
                                    户籍详细地址
                                </div>
                                <div class="col-md-4">
                                    <input id="housePlace" type="text" readonly
                                           value="${student.householdRegisterPlace}"/>
                                </div>
                                <div class="col-md-2 tar">
                                    现家庭住址
                                </div>
                                <div class="col-md-4">
                                    <input id="address" type="text" readonly value="${student.address}"/>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-md-2 tar">
                                    学生类型
                                </div>
                                <div class="col-md-4">
                                    <input id="type" type="text" readonly value="${student.studentTypeShow}"/>
                                </div>
                                <div class="col-md-2 tar">
                                    生源类型
                                </div>
                                <div class="col-md-4">
                                    <input id="source" type="text" readonly value="${student.studentSourceShow}"/>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-md-2 tar">
                                    是否低保
                                </div>
                                <div class="col-md-4">
                                    <input id="allowances" type="text" readonly value="${student.allowancesFlagShow}"/>
                                </div>
                                <div class="col-md-2 tar">
                                    是否享受国家助学金
                                </div>
                                <div class="col-md-4">
                                    <input id="grants" type="text" readonly value="${student.grantsFlagShow}"/>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-md-2 tar">
                                    教学点名称
                                </div>
                                <div class="col-md-4">
                                    <input id="teachingPlace" type="text" readonly value="${student.teachingPlace}"/>
                                </div>
                                <div class="col-md-2 tar">
                                    毕业学校
                                </div>
                                <div class="col-md-4">
                                    <input id="graduatedSchool" type="text" readonly
                                           value="${student.graduatedSchool}"/>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-md-2 tar">
                                    家庭电话
                                </div>
                                <div class="col-md-4">
                                    <input id="homePhone" type="text" readonly
                                           class="validate[required,maxSize[20]] form-control"
                                           value="${student.homePhone}"/>
                                </div>
                                <div class="col-md-2 tar">
                                    手机
                                </div>
                                <div class="col-md-4">
                                    <input id="tel" type="text" readonly
                                           class="validate[required,maxSize[20]] form-control"
                                           value="${student.tel}"/>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-md-2 tar">
                                    港澳台侨胞
                                </div>
                                <div class="col-md-4">
                                    <input id="overseas" type="text" readonly value="${student.overseasChineseShow}"/>
                                </div>
                                <div class="col-md-2 tar">
                                    备注
                                </div>
                                <div class="col-md-4">
                                    <input id="remark" name="remark" readonly value="${student.remark}"/>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane" id="tab10">
                            <div class="form-row " style="overflow-y:auto;">
                                <table id="paymentTable" cellpadding="0" cellspacing="0" width="100%"
                                       class="table table-bordered table-striped sortable_default">
                                </table>
                            </div>
                        </div>
                        <div class="tab-pane" id="tab11">
                            <div class="form-row " style="overflow-y:auto;">
                                <table id="rewardpunishCountGrid" cellpadding="0" cellspacing="0" width="100%"
                                       class="table table-bordered table-striped sortable_default">
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var paymentTable;
    var rewardpunishCountGrid;
    $(document).ready(function () {
        paymentTable = $("#paymentTable").DataTable({
            "data": ${paymentResults},
            "destroy": true,
            "columns": [
                {"data": "studentId", "visible": false},
                {"data": "classId", "visible": false},
                {"data": "planId", "visible": false},
                {"width": "10%", "data": "studentName", "title": "学生姓名"},
                {"width": "10%", "data": "planName", "title": "缴费计划"},
                {"width": "10%", "data": "planItemShow", "title": "缴费项目"},
                {"width": "10%", "data": "paymentStandard", "title": "缴费标准"},
                {"width": "10%", "data": "paymentAmount", "title": "缴费金额"},
                {"width": "10%", "data": "refundAmount", "title": "退费金额"},


            ],
            'order' : [[3,'desc'],[2,'desc'],[1,'desc']],
            "dom": 'rtlip',
            "language": language
        });

        rewardpunishCountGrid = $("#rewardpunishCountGrid").DataTable({
            "data": ${studentPunishes},
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width":"12%","data": "studentId", "title": "姓名"},
                {"width":"8%","data": "sexShow", "title": "性别"},
                {"width":"8%","data": "idcard", "title": "身份证号"},
                {"width":"12%","data": "typeShow", "title": "奖惩类型"},
                {"width":"10%","data": "departmentsId", "title": "系部"},
                {"width":"12%","data": "majorShow", "title": "专业"},
                {"width":"8%","data": "classId", "title": "班级"},
                {"width":"8%","title": "操作","render": function () {return "<a id='detail' class='icon-search' title='查看'></a>";}}
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });
        rewardpunishCountGrid.on('click', 'tr a', function () {
            var data = rewardpunishCountGrid.row($(this).parent()).data();
            var id = data.id;
            var type=data.rewardpunishType;
            if (this.id == "detail") {
                if(type=="1"){
                    $("#dialog").load("<%=request.getContextPath()%>/studentRewardPunish/studentPunish/edit?id="+id+"&flag=1");
                    $("#dialog").modal("show");
                }else if(type=="11"){
                    $("#dialog").load("<%=request.getContextPath()%>/studentRewardPunish/schoolBurse/edit?id="+id+"&flag=1");
                    $("#dialog").modal("show");
                }else if(type=="12"){
                    $("#dialog").load("<%=request.getContextPath()%>/studentRewardPunish/stateBurse/edit?id="+id+"&flag=1");
                    $("#dialog").modal("show");
                }else if(type=="13"){
                    $("#dialog").load("<%=request.getContextPath()%>/studentRewardPunish/fullBurse/edit?id="+id+"&flag=1");
                    $("#dialog").modal("show");
                }else if(type=="14"){
                    $("#dialog").load("<%=request.getContextPath()%>/studentRewardPunish/tuitionFree/edit?id="+id+"&flag=1");
                    $("#dialog").modal("show");
                }else if(type=="15"){
                    $("#dialog").load("<%=request.getContextPath()%>/studentRewardPunish/grants/edit?id="+id+"&flag=1");
                    $("#dialog").modal("show");
                }else if(type=="16"){
                    $("#dialog").load("<%=request.getContextPath()%>/studentRewardPunish/studentLoan/edit?id="+id+"&flag=1");
                    $("#dialog").modal("show");
                }else if(type=="17"){
                    $("#dialog").load("<%=request.getContextPath()%>/studentRewardPunish/studentCadres/edit?id="+id+"&flag=1");
                    $("#dialog").modal("show");
                }else{
                    $("#dialog").load("<%=request.getContextPath()%>/studentRewardPunish/miyoshiClass/edit?id="+id+"&flag=1");
                    $("#dialog").modal("show");
                }
            }
        });

    })


    function getView(id, resultType) {
        if (resultType == 1 || resultType == '1') {
            $("#dialog").load("<%=request.getContextPath()%>/teacherResult/editTeachingResult/project", {
                id: id,
                flag: "on"
            });
        } else if (resultType == 2 || resultType == '2') {
            $("#dialog").load("<%=request.getContextPath()%>/teacherResult/editTeachingResult/standard", {
                id: id,
                flag: "on"
            });
        } else if (resultType == 3 || resultType == '3') {
            $("#dialog").load("<%=request.getContextPath()%>/teacherResult/editTeachingResult/medicine", {
                id: id,
                flag: "on"
            });
        } else if (resultType == 4 || resultType == '4') {
            $("#dialog").load("<%=request.getContextPath()%>/teacherResult/editTeachingResult/paper", {
                id: id,
                flag: "on"
            });
        } else if (resultType == 5 || resultType == '5') {
            $("#dialog").load("<%=request.getContextPath()%>/teacherResult/editTeachingResult/art", {
                id: id,
                flag: "on"
            });
        } else if (resultType == 6 || resultType == '6') {
            $("#dialog").load("<%=request.getContextPath()%>/teacherResult/editTeachingResult/guide", {
                id: id,
                flag: "on"
            });
        } else if (resultType == 7 || resultType == '7') {
            $("#dialog").load("<%=request.getContextPath()%>/teacherResult/editTeachingResult/writing", {
                id: id,
                flag: "on"
            });
        } else if (resultType == 8 || resultType == '8') {
            $("#dialog").load("<%=request.getContextPath()%>/teacherResult/editTeachingResult/patent", {
                id: id,
                flag: "on"
            });
        } else if (resultType == 9 || resultType == '9') {
            $("#dialog").load("<%=request.getContextPath()%>/teacherResult/editTeachingResult/report", {
                id: id,
                flag: "on"
            });
        }
        $("#dialog").modal("show");
    }

</script>


