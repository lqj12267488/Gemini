<%--
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/10/12
  Time: 9:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog" STYLE="width: 70%;height: 60%;">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" onclick="closeView()" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title">${head}</h4>
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 姓名：
                    </div>
                    <div class="col-md-4">
                        <input id="teacherInfoName" type="text" value="${teacherCondition.teacherNameShow}"/>
                        <input id="perId" type="hidden" value="${teacherCondition.teacherName}"/>
                    </div>
                    <div class="col-md-2 tar" id="dept1" hidden >
                        教师所属系部：
                    </div>
                    <div class="col-md-2 tar" id="dept2" hidden>
                        <span class="iconBtx">*</span>任职部门：
                    </div>
                    <div class="col-md-2 tar" id="dept3" hidden>
                        <span class="iconBtx">*</span>聘任系部：
                    </div>
                    <div class="col-md-4">
                        <input id="departmentsIdSel" type="text" value="${teacherCondition.departmentIdShow}" readonly/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 教工号：
                    </div>
                    <div class="col-md-4">
                        <input id="tnum" type="text" value="${teacherCondition.teacherNum}"/>
                    </div>
                    <div class="col-md-2 tar" id="xingzhengzw" hidden>
                        <span class="iconBtx">*</span> 行政职务：
                    </div>
                    <div class="col-md-4" id="xingzhengzw2" hidden>
                        <input id="xzzw" type="text" value="${teacherCondition.xzPosition}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 性别：
                    </div>
                    <div class="col-md-4">
                        <select id="tsex"/>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 出生日期：
                    </div>
                    <div class="col-md-4">
                        <input id="birthday" type="date" value="${teacherCondition.birthday}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 民族：
                    </div>
                    <div class="col-md-4">
                        <select id="nationShow"/>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>教师性质：
                    </div>
                    <div class="col-md-4">
                        <select id="teacherCategory" onclick="tlb()"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 最后学历：
                    </div>
                    <div class="col-md-4">
                        <select id="finalEducation"/>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 最后学历学位：
                    </div>
                    <div class="col-md-4">
                        <select id="degee"/>
                    </div>
                </div>
                <div class="form-row" id="zhuanye" hidden>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 专业领域：
                    </div>
                    <div class="col-md-4">
                        <input id="lingyu" type="text" value="${teacherCondition.majorField}"/>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 专业特长：
                    </div>
                    <div class="col-md-4">
                        <input id="techang" type="text" value="${teacherCondition.majorSpecialty}"/>
                    </div>
                </div>
                <div class="form-row" id="qiye" hidden>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>企业工作时间(年)：
                    </div>
                    <div class="col-md-4">
                        <input id="qiyeyear" type="text" value="${teacherCondition.qiyeYear}"/>
                    </div>

                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>企业工作本学年(天)：
                    </div>
                    <div class="col-md-4">
                        <input id="qiyeday" type="number" value="${teacherCondition.qiyeDate}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>专业技术职务名称：
                    </div>
                    <div class="col-md-4">
                        <input id="zyname" type="text" value="${teacherCondition.majorName}"/>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>专业技术职务等级：
                    </div>
                    <div class="col-md-4">
                        <input id="zydj" type="text" value="${teacherCondition.majorGrade}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>专业技术职务发证机关：
                    </div>
                    <div class="col-md-4">
                        <input id="zydept" type="text" value="${teacherCondition.majorDept}"/>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>专业技术职务获得时间：
                    </div>
                    <div class="col-md-4">
                        <input id="zydate" type="month" value="${teacherCondition.majorDate}"/>
                    </div>
                </div>

                <%--校内兼课教师区域id=njr--%>
                    <div class="form-row" id="njr" hidden>
                        <div class="form-row">
                            <div class="col-md-2 tar">
                                <span class="iconBtx">*</span> 籍贯：
                            </div>
                            <div class="col-md-4">
                                <input id="nativePlace" type="text" value="${teacherCondition.nativePlace}"/>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-2 tar">
                                <span class="iconBtx">*</span> 政治面貌：
                            </div>
                            <div class="col-md-4">
                                <select id="politicalStatusShow" value="${teacherCondition.politicalStatusShow}"/>
                            </div>
                            <div class="col-md-2 tar">
                                <span class="iconBtx">*</span> 第一学历：
                            </div>
                            <div class="col-md-4">
                                <select id="firstEducation" />
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-2 tar">
                                <span class="iconBtx">*</span> 第一学历学位：
                            </div>
                            <div class="col-md-4">
                                <select id="firstEducationStatus" />
                            </div>
                            <div class="col-md-2 tar">
                                <span class="iconBtx">*</span> 第一学历毕业院校：
                            </div>
                            <div class="col-md-4">
                                <input id="firstEducationSchool" type="text" value="${teacherCondition.firstEducationSchool}"/>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-2 tar">
                                <span class="iconBtx">*</span> 第一学历专业：
                            </div>
                            <div class="col-md-4">
                                <input id="firstEducationMajor" type="text" value="${teacherCondition.firstEducationMajor}"/>
                            </div>
                            <div class="col-md-2 tar">
                                <span class="iconBtx">*</span> 第一学历毕业时间：
                            </div>
                            <div class="col-md-4">
                                <input id="firstEndtime" type="date" value="${teacherCondition.firsEndtime}"/>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-2 tar">
                                <span class="iconBtx">*</span> 最后学历毕业院校：
                            </div>
                            <div class="col-md-4">
                                <input id="finalEducationSchool" type="text" value="${teacherCondition.finalEducationSchool}"/>
                            </div>
                            <div class="col-md-2 tar">
                                <span class="iconBtx">*</span>最后学历专业：
                            </div>
                            <div class="col-md-4">
                                <input id="subject" type="text" value="${teacherCondition.major}"/>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-2 tar">
                                <span class="iconBtx">*</span> 最后学历毕业时间：
                            </div>
                            <div class="col-md-4">
                                <input id="finalEndTime" type="date" value="${teacherCondition.finaleEndtime}"/>
                            </div>
                            <div class="col-md-2 tar">
                                <span class="iconBtx">*</span>是否专业教师：
                            </div>
                            <div class="col-md-4">
                                <select id="sfzy"/>
                            </div>
                        </div>
                    </div>

                <div class="form-row" id="zhiyezg" hidden>
                    <div class="form-row">
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>职业资格等级：
                        </div>
                        <div class="col-md-4">
                            <input id="zhiyeGrade" type="text" value="${teacherCondition.careerGrade}"/>
                        </div>
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>职业资格名称：
                        </div>
                        <div class="col-md-4">
                            <input id="zhiyeName" type="text" value="${teacherCondition.careerName}"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>职业资格发证单位：
                        </div>
                        <div class="col-md-4">
                            <input id="zhiyeDept" type="text" value="${teacherCondition.careerDept}"/>
                        </div>
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>职业资格获取日期：
                        </div>
                        <div class="col-md-4">
                            <input id="zhiyeDate" type="month" value="${teacherCondition.careerGettime}"/>
                        </div>
                    </div>
                </div>

                <div class="form-row" id="jszg" hidden>
                    <div class="form-row">
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span> 教师资格发证单位：
                        </div>
                        <div class="col-md-4">
                            <input id="licence" type="text" value="${teacherCondition.licence}"/>
                        </div>
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span> 教师资格获得时间：
                        </div>
                        <div class="col-md-4">
                            <input id="getTime" type="month" value="${teacherCondition.getTime}"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>是否骨干教师：
                        </div>
                        <div class="col-md-4">
                            <select id="sfgg"/>
                        </div>
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>是否双师素质教师：
                        </div>
                        <div class="col-md-4">
                            <select id="sfss"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>是否教学名师：
                        </div>
                        <div class="col-md-4">
                            <select id="sfms"/>
                        </div>
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>已聘职称：
                        </div>
                        <div class="col-md-4">
                            <input id="teacherTitle" type="text" value="${teacherCondition.title}"/>
                        </div>
                    </div>
                </div>
                <div class="form-row" id="srzw" hidden>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>所任职务：
                    </div>
                    <div class="col-md-4">
                        <input id="tozhiwu" type="text" value="${teacherCondition.srPosition}"/>
                    </div>
                </div>
                <%--行政所属专业--%>
                <div class="form-row" id="xingzheng" hidden>
                    <div class="form-row">
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>行政所属专业代码：
                        </div>
                        <div class="col-md-4">
                            <input id="xzCode" type="text" value="${teacherCondition.politicsMajorCode}"/>
                        </div>
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>行政所属专业名称：
                        </div>
                        <div class="col-md-4">
                            <input id="xzName" type="text" value="${teacherCondition.politicsMajorName}"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>派出部门：
                        </div>
                        <div class="col-md-4">
                            <input id="pcdept" type="text" value="${teacherCondition.sendDept}"/>
                        </div>
                    </div>
                </div>
                <%--校外兼职教师--%>
                <div class="form-row" id="xwjz" hidden>
                    <div class="form-row">
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>当前专职单位名称：
                        </div>
                        <div class="col-md-4">
                            <input id="zhuanzhiDept" type="text" value="${teacherCondition.expertDept}"/>
                        </div>
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>当前专职职务：
                        </div>
                        <div class="col-md-4">
                            <input id="zhuanzhi" type="text" value="${teacherCondition.expertWork}"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>当前专职任职日期：
                        </div>
                        <div class="col-md-4">
                            <input id="zhuanzhiDate" type="month" value="${teacherCondition.expertDate}"/>
                        </div>
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>教学进修项目名称：
                        </div>
                        <div class="col-md-4">
                            <input id="jioaxuename" type="text" value="${teacherCondition.trainingName}"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>教学进修时间(天)：
                        </div>
                        <div class="col-md-4">
                            <input id="jiaoxueDay" type="number" value="${teacherCondition.trainingDay}"/>
                        </div>
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>教学进修地点：
                        </div>
                        <div class="col-md-4">
                            <input id="jioaxuenmap" type="text" value="${teacherCondition.trainingPlace}"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>参加工作日期：
                        </div>
                        <div class="col-md-4">
                            <input id="workdate" type="month" value="${teacherCondition.workDate}"/>
                        </div>
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>签约情况：
                        </div>
                        <div class="col-md-4">
                            <input id="qyflag" type="text" value="${teacherCondition.signing}"/>
                        </div>
                    </div>
                </div>
                <div class="col-md-2 tar">
                    <span class="iconBtx">*</span>工作单位：
                </div>
                <div class="col-md-4">
                    <input id="wdept" type="text" value="${teacherCondition.workDept}"/>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button id="save" type="button" class="btn btn-success btn-clean" onclick="save()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal" onclick="closeView()">关闭
            </button>
        </div>
    </div>
    <input id="teacherId" value="${teacherCondition.teacherId}" type="hidden">
</div>

<script>
    var aaa;
    $(document).ready(function () {
        if('${type}'=='show'){
            $("input").attr('readonly',true);
            $("select").attr("disabled","disabled");
            $("#save").css('display','none');
        }
        $.get("<%=request.getContextPath()%>/common/getPersonDept", function (data) {
            $("#teacherInfoName").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#teacherInfoName").val(ui.item.label.split(" ---- ")[0]);
                    $("#departmentsIdSel").val(ui.item.label.split(" ---- ")[1]);
                    $("#teacherInfoName").attr("keycode", ui.item.value);

                    $("#perId").val(ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XL", function (data) {
            addOption(data, 'firstEducation','${teacherCondition.firstEducation}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XW", function (data) {
            addOption(data, 'firstEducationStatus','${teacherCondition.firstEducationStatus}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XL", function (data) {
            addOption(data, 'finalEducation','${teacherCondition.finalEducation}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XW", function (data) {
            addOption(data, 'degee','${teacherCondition.degee}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XB", function (data) {
            addOption(data, 'tsex','${teacherCondition.teacherSex}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=SF", function (data) {
            addOption(data, 'sfzy','${teacherCondition.sfzyTeacher}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=SF", function (data) {
            addOption(data, 'sfgg','${teacherCondition.sfggTeacher}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=SF", function (data) {
            addOption(data, 'sfss','${teacherCondition.sfssTeacher}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=SF", function (data) {
            addOption(data, 'sfms','${teacherCondition.sfmsTeacher}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JSLB", function (data) {
            addOption(data, 'teacherCategory', '${teacherCondition.teacherCategory}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=MZ", function (data) {
            addOption(data, 'nationShow', '${teacherCondition.nation}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZZMM", function (data) {
            addOption(data, 'politicalStatusShow', '${teacherCondition.politicalStatus}');
        });
        tlb();
    })

    function tlb() {
        /*1:校内专任教师
        * 2:校外兼课教师
        * 3:校外兼职教师
        * 4:校内兼课教师*/
        var tc = "";
        if($('#teacherCategory option:selected').val()==undefined){
            tc = '${teacherCondition.teacherCategory}';
        }else {
            tc = $('#teacherCategory').val();
        }

        if (tc == '1') {
            $('#dept1').show();
            $('#dept2').hide();
            $('#dept3').hide();
            $('#njr').show();
            $('#qiye').show();
            $('#zhuanye').show();
            $('#jszg').show();
            $('#zhiyezg').show();
            $('#xingzheng').show();
            $('#xingzhengzw').show();
            $('#xingzhengzw2').show();
            $('#srzw').hide();
        } else if (tc != '' && tc == '4') {
            $('#dept1').hide();
            $('#dept2').show();
            $('#dept3').hide();
            $('#njr').hide();
            $('#zhiyezg').hide();
            $('#qiye').show();
            $('#zhuanye').show();
            $('#jszg').show();
            $('#xingzheng').show();
            $('#xwjz').hide();
            $('#srzw').show();
            $('#xingzhengzw').hide();
            $('#xingzhengzw2').hide();
        }else if(tc != '' && tc == '3'){
            $('#dept1').hide();
            $('#dept2').hide();
            $('#dept3').show();
            $('#njr').hide();
            $('#qiye').hide();
            $('#zhuanye').hide();
            $('#zhiyezg').show();
            $('#jszg').hide();
            $('#xingzheng').show();
            $('#xwjz').show();
            $('#xingzhengzw').hide();
            $('#xingzhengzw2').hide();
            $('#srzw').hide();
        }else if(tc !='' && tc=='2'){
            $('#dept1').hide();
            $('#dept2').hide();
            $('#dept3').show();
            $('#njr').hide();
            $('#qiye').hide();
            $('#zhuanye').hide();
            $('#zhiyezg').show();
            $('#jszg').hide();
            $('#xingzheng').hide();
            $('#xwjz').show();
            $('#xingzhengzw').hide();
            $('#xingzhengzw2').hide();
            $('#srzw').hide();
        }else {
            $('#dept1').show();
            $('#dept2').hide();
            $('#dept3').hide();
        }
    }

    function save() {
        var deptId=$("#perId").val().split(",")[0];
        var personId=$("#perId").val().split(",")[1];
        if(personId==undefined){
            deptId='${teacherCondition.departmentId}';
            personId='${teacherCondition.teacherName}';
        }
        var tc = $('#teacherCategory').val();
        if ($("#perId").val() == "" || $("#perId").val() == undefined) {
            swal({title: "请填写姓名！", type: "info"});
            return;
        }
        if ($("#tnum").val() == "" || $("#tnum").val() == undefined ||$("#tnum").val()==null) {
            swal({title: "请填写教工号", type: "info"});
            return;
        }
        if ($("#tsex").val() == "" || $("#tsex").val() == undefined) {
            swal({title: "请选择性别！", type: "info"});
            return;
        }
        if ($("#birthday").val() == "" || $("#birthday").val() == undefined) {
            swal({title: "请填写精确的出生日期！", type: "info"});
            return;
        }
        if ($("#nationShow").val() == "" || $("#nationShow").val() == undefined) {
            swal({title: "请选择民族！", type: "info"});
            return;
        }
        if ($('#teacherCategory option:selected').val() == "" || $('#teacherCategory option:selected').val() == undefined) {
            swal({title: "请选择教师性质！", type: "info"});
            return;
        }
        if ($("#finalEducation").val() == "" || $("#finalEducation").val() == undefined) {
            swal({title: "请填写最后学历！", type: "info"});
            return;
        }
        if ($("#degee").val() == "" || $("#degee").val() == undefined) {
            swal({title: "请填写最后学历学位！", type: "info"});
            return;
        }
        if ($("#zydj").val() == "" || $("#zydj").val() == undefined) {
            swal({title: "请填写专业技术职务等级！", type: "info"});
            return;
        }
        if ($("#zyname").val() == "" || $("#zyname").val() == undefined) {
            swal({title: "请填写专业技术职务名称！", type: "info"});
            return;
        }
        if ($("#zydept").val() == "" || $("#zydept").val() == undefined) {
            swal({title: "请填写专业技术职务发证机关！", type: "info"});
            return;
        }
        if ($("#zydate").val() == "" || $("#zydate").val() == undefined) {
            swal({title: "请填写专业技术职务获得时间！", type: "info"});
            return;
        }
        /*校内兼课教师*/
        if (tc == '4') {
            if ($("#lingyu").val() == "" || $("#lingyu").val() == undefined) {
                swal({title: "请填写专业领域！", type: "info"});
                return;
            }
            if ($("#techang").val() == "" || $("#techang").val() == undefined) {
                swal({title: "请填写专业特长！", type: "info"});
                return;
            }
            if ($("#qiyeyear").val() == "" || $("#qiyeyear").val() == undefined) {
                swal({title: "请填写企业工作时间(年)！", type: "info"});
                return;
            }
            if ($("#qiyeday").val() == "" || $("#qiyeday").val() == undefined) {
                swal({title: "请填写企业工作本学年(天)！", type: "info"});
                return;
            }
            if ($("#licence").val() == "" || $("#licence").val() == undefined) {
                swal({title: "请填写教师资格发证单位！", type: "info"});
                return;
            }
            if ($("#getTime").val() == "" || $("#getTime").val() == undefined) {
                swal({title: "请填写教师资获得时间！", type: "info"});
                return;
            }
            if ($('#sfgg option:selected').val() == "" || $('#sfgg option:selected').val() == undefined) {
                swal({title: "请选择是否骨干教师！", type: "info"});
                return;
            }
            if ($('#sfss option:selected').val() == "" || $('#sfss option:selected').val() == undefined) {
                swal({title: "请选择是否双师素质教师！", type: "info"});
                return;
            }
            if ($('#sfms option:selected').val() == "" || $('#sfms option:selected').val() == undefined) {
                swal({title: "请选择是否教学名师！", type: "info"});
                return;
            }
            if ($("#teacherTitle").val() == "" || $("#teacherTitle").val() == undefined) {
                swal({title: "请填写已聘职称！", type: "info"});
                return;
            }
            if ($("#tozhiwu").val() == "" || $("#tozhiwu").val() == undefined) {
                swal({title: "请填写所任职务！", type: "info"});
                return;
            }
            if ($("#xzCode").val() == "" || $("#xzCode").val() == undefined) {
                swal({title: "请填写行政所属专业代码！", type: "info"});
                return;
            }
            if ($("#xzName").val() == "" || $("#xzName").val() == undefined) {
                swal({title: "请填写行政所属专业名称！", type: "info"});
                return;
            }
            if ($("#pcdept").val() == "" || $("#pcdept").val() == undefined) {
                swal({title: "请填写派出部门！", type: "info"});
                return;
            }
        }
        /*校外兼职教师*/
        if (tc == '3') {
            if ($("#zhiyeGrade").val() == "" || $("#zhiyeGrade").val() == undefined) {
                swal({title: "请填写职业资格等级！", type: "info"});
                return;
            }
            if ($("#zhiyeName").val() == "" || $("#zhiyeName").val() == undefined) {
                swal({title: "请填写职业资格名称！", type: "info"});
                return;
            }
            if ($("#zhiyeDept").val() == "" || $("#zhiyeDept").val() == undefined) {
                swal({title: "请填写职业资格发证单位！", type: "info"});
                return;
            }
            if ($("#zhiyeDate").val() == "" || $("#zhiyeDate").val() == undefined) {
                swal({title: "请填写职业资格获取日期！", type: "info"});
                return;
            }
            if ($("#xzCode").val() == "" || $("#xzCode").val() == undefined) {
                swal({title: "请填写行政所属专业代码！", type: "info"});
                return;
            }
            if ($("#xzName").val() == "" || $("#xzName").val() == undefined) {
                swal({title: "请填写行政所属专业名称！", type: "info"});
                return;
            }
            if ($("#pcdept").val() == "" || $("#pcdept").val() == undefined) {
                swal({title: "请填写派出部门！", type: "info"});
                return;
            }
            if ($("#zhuanzhiDept").val() == "" || $("#zhuanzhiDept").val() == undefined) {
                swal({title: "请填写当前专职单位名称！", type: "info"});
                return;
            }
            if ($("#zhuanzhi").val() == "" || $("#zhuanzhi").val() == undefined) {
                swal({title: "请填写当前专职职务！", type: "info"});
                return;
            }
            if ($("#zhuanzhiDate").val() == "" || $("#zhuanzhiDate").val() == undefined) {
                swal({title: "请填写当前专职任职日期！", type: "info"});
                return;
            }
            if ($("#jioaxuename").val() == "" || $("#jioaxuename").val() == undefined) {
                swal({title: "请填写教学进修项目名称！", type: "info"});
                return;
            }
            if ($("#jiaoxueDay").val() == "" || $("#jiaoxueDay").val() == undefined) {
                swal({title: "请填写教学进修时间(天)！", type: "info"});
                return;
            }
            if ($("#jioaxuenmap").val() == "" || $("#jioaxuenmap").val() == undefined) {
                swal({title: "请填写教学进修地点！", type: "info"});
                return;
            }
            if ($("#workdate").val() == "" || $("#workdate").val() == undefined) {
                swal({title: "请填写参加工作日期！", type: "info"});
                return;
            }
            if ($("#qyflag").val() == "" || $("#qyflag").val() == undefined) {
                swal({title: "请填写签约情况！", type: "info"});
                return;
            }
        }
        /*校外兼课教师*/
        if (tc == '2') {
            if ($("#zhiyeGrade").val() == "" || $("#zhiyeGrade").val() == undefined) {
                swal({title: "请填写职业资格等级！", type: "info"});
                return;
            }
            if ($("#zhiyeName").val() == "" || $("#zhiyeName").val() == undefined) {
                swal({title: "请填写职业资格名称！", type: "info"});
                return;
            }
            if ($("#zhiyeDept").val() == "" || $("#zhiyeDept").val() == undefined) {
                swal({title: "请填写职业资格发证单位！", type: "info"});
                return;
            }
            if ($("#zhiyeDate").val() == "" || $("#zhiyeDate").val() == undefined) {
                swal({title: "请填写职业资格获取日期！", type: "info"});
                return;
            }
            if ($("#zhuanzhiDept").val() == "" || $("#zhuanzhiDept").val() == undefined) {
                swal({title: "请填写当前专职单位名称！", type: "info"});
                return;
            }
            if ($("#zhuanzhi").val() == "" || $("#zhuanzhi").val() == undefined) {
                swal({title: "请填写当前专职职务！", type: "info"});
                return;
            }
            if ($("#zhuanzhiDate").val() == "" || $("#zhuanzhiDate").val() == undefined) {
                swal({title: "请填写当前专职任职日期！", type: "info"});
                return;
            }
            if ($("#jioaxuename").val() == "" || $("#jioaxuename").val() == undefined) {
                swal({title: "请填写教学进修项目名称！", type: "info"});
                return;
            }
            if ($("#jiaoxueDay").val() == "" || $("#jiaoxueDay").val() == undefined) {
                swal({title: "请填写教学进修时间(天)！", type: "info"});
                return;
            }
            if ($("#jioaxuenmap").val() == "" || $("#jioaxuenmap").val() == undefined) {
                swal({title: "请填写教学进修地点！", type: "info"});
                return;
            }
            if ($("#workdate").val() == "" || $("#workdate").val() == undefined) {
                swal({title: "请填写参加工作日期！", type: "info"});
                return;
            }
            if ($("#qyflag").val() == "" || $("#qyflag").val() == undefined) {
                swal({title: "请填写签约情况！", type: "info"});
                return;
            }
        }
        /*校内专任教师*/
        if (tc == '1') {
            if ($("#xzzw").val() == "" || $("#xzzw").val() == undefined) {
                swal({title: "请填写行政职务！", type: "info"});
                return;
            }
            if ($("#nativePlace").val() == "" || $("#nativePlace").val() == undefined) {
                swal({title: "请填写籍贯！", type: "info"});
                return;
            }
            if ($("#politicalStatusShow").val() == "" || $("#politicalStatusShow").val() == undefined) {
                swal({title: "请选择政治面貌！", type: "info"});
                return;
            }
            if ($("#firstEducation").val() == "" || $("#firstEducation").val() == undefined) {
                swal({title: "请填写第一学历！", type: "info"});
                return;
            }
            if ($("#firstEducationStatus").val() == "" || $("#firstEducationStatus").val() == undefined) {
                swal({title: "请填写第一学历学位！", type: "info"});
                return;
            }
            if ($("#firstEducationSchool").val() == "" || $("#firstEducationSchool").val() == undefined) {
                swal({title: "请填写第一学历毕业院校！", type: "info"});
                return;
            }
            if ($("#firstEducationMajor").val() == "" || $("#firstEducationMajor").val() == undefined) {
                swal({title: "请填写第一学历专业！", type: "info"});
                return;
            }
            if ($("#firstEndtime").val() == "" || $("#firstEndtime").val() == null || $("#firstEndtime").val() == undefined) {
                swal({title: "请选择第一学历毕业时间", type: "info"});
                return;
            }
            if ($("#finalEducationSchool").val() == "" || $("#finalEducationSchool").val() == undefined) {
                swal({title: "请填写最后学历毕业院校！", type: "info"});
                return;
            }
            if ($("#subject").val() == "" || $("#subject").val() == undefined) {
                swal({title: "请填写最后学历专业！", type: "info"});
                return;
            }
            if ($("#finalEndTime").val() == "" || $("#finalEndTime").val() == undefined || $("#finalEndTime").val() == null) {
                swal({title: "请选择最后学历毕业时间！", type: "info"});
                return;
            }
            if ($("#sfzy").val() == "" || $("#sfzy").val() == undefined || $("#sfzy").val() == null) {
                swal({title: "请选择是否专业教师！", type: "info"});
                return;
            }
            if ($("#zhiyeGrade").val() == "" || $("#zhiyeGrade").val() == undefined) {
                swal({title: "请填写职业资格等级！", type: "info"});
                return;
            }
            if ($("#zhiyeName").val() == "" || $("#zhiyeName").val() == undefined) {
                swal({title: "请填写职业资格名称！", type: "info"});
                return;
            }
            if ($("#zhiyeDept").val() == "" || $("#zhiyeDept").val() == undefined) {
                swal({title: "请填写职业资格发证单位！", type: "info"});
                return;
            }
            if ($("#zhiyeDate").val() == "" || $("#zhiyeDate").val() == undefined) {
                swal({title: "请填写职业资格获取日期！", type: "info"});
                return;
            }
            if ($("#licence").val() == "" || $("#licence").val() == undefined) {
                swal({title: "请填写教师资格发证单位！", type: "info"});
                return;
            }
            if ($("#getTime").val() == "" || $("#getTime").val() == undefined) {
                swal({title: "请填写教师资获得时间！", type: "info"});
                return;
            }
            if ($('#sfgg option:selected').val() == "" || $('#sfgg option:selected').val() == undefined) {
                swal({title: "请选择是否骨干教师！", type: "info"});
                return;
            }
            if ($('#sfss option:selected').val() == "" || $('#sfss option:selected').val() == undefined) {
                swal({title: "请选择是否双师素质教师！", type: "info"});
                return;
            }
            if ($('#sfms option:selected').val() == "" || $('#sfms option:selected').val() == undefined) {
                swal({title: "请选择是否教学名师！", type: "info"});
                return;
            }
            if ($("#teacherTitle").val() == "" || $("#teacherTitle").val() == undefined) {
                swal({title: "请填写已聘职称！", type: "info"});
                return;
            }
            if ($("#xzCode").val() == "" || $("#xzCode").val() == undefined) {
                swal({title: "请填写行政所属专业代码！", type: "info"});
                return;
            }
            if ($("#xzName").val() == "" || $("#xzName").val() == undefined) {
                swal({title: "请填写行政所属专业名称！", type: "info"});
                return;
            }
            if ($("#pcdept").val() == "" || $("#pcdept").val() == undefined) {
                swal({title: "请填写派出部门！", type: "info"});
                return;
            }
        }
            if($("#wdept").val()=="" || $("#wdept").val() == undefined || $("#wdept").val() == null){
                swal({title: "请填写工作单位！", type: "info"});
                return;
            }
        $.post("<%=request.getContextPath()%>/teacher/saveTeacherInfo", {
            teacherId: $("#teacherId").val(),
            teacherName: personId,
            departmentId: deptId,
            teacherNum:$("#tnum").val(),
            teacherSex:$("#tsex").val(),
            birthday:$("#birthday").val(),
            nation: $("#nationShow").val(),
            teacherCategory: $('#teacherCategory option:selected').val(),
            finalEducation: $("#finalEducation").val(),
            degee: $("#degee").val(),
            majorGrade:$("#zydj").val(),
            majorName:$("#zyname").val(),
            majorDept:$("#zydept").val(),
            majorDate:$("#zydate").val(),
            xzPosition: $("#xzzw").val(),
            majorField: $("#lingyu").val(),
            majorSpecialty: $("#techang").val(),
            qiyeYear: $("#qiyeyear").val(),
            qiyeDate:$("#qiyeday").val(),
            nativePlace: $("#nativePlace").val(),
            politicalStatus: $("#politicalStatusShow").val(),
            firstEducationStatus: $("#firstEducationStatus").val(),
            firstEducation: $("#firstEducation").val(),
            firstEducationSchool: $("#firstEducationSchool").val(),
            firstEducationMajor: $("#firstEducationMajor").val(),
            firsEndtime: $("#firstEndtime").val(),
            finalEducationSchool:$("#finalEducationSchool").val(),
            finaleEndtime:$("#finalEndTime").val(),
            sfzyTeacher:$("#sfzy").val(),
            licence: $("#licence").val(),
            getTime: $("#getTime").val(),
            sfggTeacher:$("#sfgg").val(),
            sfssTeacher:$("#sfss").val(),
            sfmsTeacher:$("#sfms").val(),
            major: $("#subject").val(),
            title:$("#teacherTitle").val(),
            careerGrade:$("#zhiyeGrade").val(),
            careerName:$("#zhiyeName").val(),
            careerDept:$("#zhiyeDept").val(),
            careerGettime:$("#zhiyeDate").val(),
            expertDept:$("#zhuanzhiDept").val(),
            expertWork:$("#zhuanzhi").val(),
            expertDate:$("#zhuanzhiDate").val(),
            trainingName:$("#jioaxuename").val(),
            trainingDay:$("#jiaoxueDay").val(),
            trainingPlace:$("#jioaxuenmap").val(),
            workDate:$("#workdate").val(),
            signing:$("#qyflag").val(),
            sendDept:$("#pcdept").val(),
            politicsMajorCode:$("#xzCode").val(),
            politicsMajorName:$("#xzName").val(),
            srPosition:$("#tozhiwu").val(),
            workDept:$("#wdept").val()
        }, function (msg) {
            swal({title: msg.msg, type: "success"});
            $("#dialog").modal('hide');
            $('#scoreExamGrid').DataTable().ajax.reload();
        })
    }

    //关闭
    function closeView() {
        $("#dialog").css('display','none');
    }
</script>