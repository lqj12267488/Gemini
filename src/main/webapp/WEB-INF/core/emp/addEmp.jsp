<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %><%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/25
  Time: 18:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link href="/libs/css/stylesheets.css" rel="stylesheet" type="text/css">
<style>
</style>

<div class="modal-dialog" style="width: 800px">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title">新增</h4>
        </div>
        <div class="modal-body clearfix" style="font-size: 15px;">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>姓名
                    </div>
                    <div class="col-md-3">
                        <input id="name" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               class="validate[required,maxSize[20]] form-control"/>
                    </div>
                    <div style="float: right;width: 354px;height: 150px;">
                        <div style="width: 218px;height: 150px;margin-top: -4px;">
                            <img id="photo" style="border: 1px dashed #ffffff
                            ;width: 136px;height: 172px;margin-top: 2px;margin-left: 58px"
                                 src="<%=request.getContextPath()%>/idcardimg/bg.png">
                        </div>
                    </div>
                    <%--<div class="col-md-2 tar" style="margin-top: 2%">
                        曾用名
                    </div>
                    <div class="col-md-3" style="margin-top: 2%">
                        <input id="usedName" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;" />
                    </div>--%>
                    <div class="col-md-2 tar" style="margin-top: 2%">
                        <span class="iconBtx">*</span>岗位
                   </div>
                   <div class="col-md-3" style="margin-top: 2%">
                       <select id="jobSel" class="js-example-basic-single" />
                   </div>

                    <div class="col-md-2 tar" style="margin-top: 2%">
                        <span class="iconBtx">*</span>性别
                    </div>
                    <div class="col-md-3" style="margin-top: 2%">
                        <select id="sex" class="js-example-basic-single"></select>
                    </div>


                   <div class="col-md-2 tar" style="margin-top: 2%">
                       <span class="iconBtx"></span>籍贯
                   </div>
                    <div class="col-md-3" style="margin-top: 2%">
                        <input id="jg" class="js-example-basic-single"></input>
                    </div>
                  <%-- <div class="col-md-3" style="margin-top: 2%;margin-bottom: 4px;">
                       <input id="idCard" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                              class="validate[required,minSize[5],maxSize[10]] form-control"/>
                   </div>--%>
                </div>
                <div class="form-row">
                       <div class="col-md-2 tar">
                           <span class="iconBtx">*</span>入职日期
                       </div>
                       <div class="col-md-3">
                           <input id="rz" type="date"/>
                       </div>

                       <div class="col-md-2 tar">
                           <span class="iconBtx"></span>户口所在地
                       </div>
                       <div class="col-md-3">
                           <input id="hkszd" type="text"/>
                       </div>

                </div>
                <div class="form-row">
                       <div class="col-md-2 tar">
                              民族
                       </div>
                      <div class="col-md-3">
                        <select id="nation" class="js-example-basic-single"></select>
                      </div>

                        <div class="col-md-2 tar">
                            <span class="iconBtx"></span>户口所在地区
                        </div>
                        <div class="col-md-3">
                            <input id="hkszdqSel" type="text"/>
                        </div>

                </div>
                <div class="form-row">

                    <%--<div class="col-md-2 tar">
                        国籍
                    </div>
                    <div class="col-md-3">
                        <select id="nationality" class="js-example-basic-single"></select>
                    </div>--%>
                       <div class="col-md-2 tar">
                           <span class="iconBtx"></span>级别
                       </div>
                       <div class="col-md-3">
                           <input id="levelSel" type="text"/>
                       </div>
                       <div class="col-md-2 tar">
                           婚姻状况
                       </div>
                       <div class="col-md-3">
                           <select id="maritalStatus" class="js-example-basic-single"></select>
                       </div>
                </div>
                <div class="form-row">
                   <%-- <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>教职工编号
                    </div>
                    <div class="col-md-3">
                        <input id="staffId" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"/>
                    </div>
                    <div class="col-md-2 tar">
                        出生地
                    </div>
                    <div class="col-md-3">
                        <input id="birthPlace" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"/>
                    </div>--%>
                      <div class="col-md-2 tar">
                           <span class="iconBtx">*</span>出生日期
                       </div>
                       <div class="col-md-3">
                           <input id="birthday" type="date"/>
                       </div>

                       <div class="col-md-2 tar">
                           是否政审
                       </div>
                       <div class="col-md-3">
                           <select id="sfzs" class="js-example-basic-single"></select>
                       </div>

                </div>
                <div class="form-row">
                    <%--<div class="col-md-2 tar">
                        籍贯省
                    </div>
                    <div class="col-md-3">
                        <select id="nativePlaceProvince" class="js-example-basic-single">
                        </select>
                    </div>
                    <div class="col-md-2 tar">
                        籍贯市
                    </div>
                    <div class="col-md-3">
                        <select id="nativePlaceCity" class="js-example-basic-single">
                            <option value="">请选择</option>
                        </select>
                    </div>--%>
                         <div class="col-md-2 tar" style="margin-top: 2%">
                            <span class="iconBtx">*</span>证件类型
                        </div>
                        <div class="col-md-3" style="margin-top: 2%">
                            <select id="idType" class="js-example-basic-single"></select>
                        </div>

                      <div class="col-md-2 tar">
                          现住址
                      </div>
                      <div class="col-md-3">
                          <input id="address" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"/>
                      </div>
                </div>
                <div class="form-row">
                    <%--<div class="col-md-2 tar">
                        籍贯县(区)
                    </div>
                    <div class="col-md-3">
                        <select id="nativePlaceCounty" class="js-example-basic-single">
                            <option value="">请选择</option>
                        </select>
                    </div>--%>

                      <div class="col-md-2 tar" id="idTypeCode" style="margin-top: 2%">
                          <span class="iconBtx">*</span>证件号
                      </div>
                      <div class="col-md-3" style="margin-top: 2%;margin-bottom: 4px;">
                          <input id="idCard" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                                 class="validate[required,minSize[5],maxSize[10]] form-control"/>
                      </div>
                    <div class="col-md-2 tar">
                        政治面貌
                    </div>
                    <div class="col-md-3">
                        <select id="politicalStatus" class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row">

                    <%--<div class="col-md-2 tar">
                        健康状况
                    </div>
                    <div class="col-md-3">
                        <select id="healthStatus" class="js-example-basic-single"></select>
                    </div>--%>
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>联系方式
                        </div>
                        <div class="col-md-3">
                            <input id="tel" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"/>
                        </div>
                        <div class="col-md-2 tar">
                            文化程度
                        </div>
                        <div class="col-md-3">
                            <select id="educational_level" class="js-example-basic-single"></select>
                        </div>
                </div>
                <div class="form-row">
                   <%-- <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 参加工作时间
                    </div>
                    <div class="col-md-3">
                        <input id="workTime" type="date" value="${newdate}"/>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>来校时间
                    </div>
                    <div class="col-md-3">
                        <input id="toSchoolTime" type="date" value="${newdate}"/>
                    </div>--%>
                       <div class="col-md-2 tar">
                           教育方式
                       </div>
                       <div class="col-md-3">
                           <select id="education_technique" class="js-example-basic-single"></select>
                       </div>
                       <div class="col-md-2 tar">
                           毕业院校
                       </div>
                       <div class="col-md-3">
                           <input id="graduate_school" class="js-example-basic-single"></input>
                       </div>
                </div>
                <div class="form-row">
                  <%--  <div class="col-md-2 tar">
                        教职工所属
                    </div>
                    <div class="col-md-3">
                        <select id="staffBelongs" class="js-example-basic-single"></select>
                    </div>
                    <div class="col-md-2 tar">
                        教职工来源
                    </div>
                    <div class="col-md-3">
                        <select id="staffSource" class="js-example-basic-single">
                            <option value="">请选择所属</option>
                        </select>
                    </div>--%>
                      <div class="col-md-2 tar">
                          毕业时间
                      </div>
                      <div class="col-md-3">
                          <input id="graduate_time" class="js-example-basic-single" type="date"></input>
                      </div>
                      <div class="col-md-2 tar">
                          专业
                      </div>
                      <div class="col-md-3">
                          <input id="majorSel" class="js-example-basic-single" type="text"></input>
                      </div>
                </div>
                <div class="form-row">
                  <%--  <div class="col-md-2 tar">
                        教职工类别
                    </div>
                    <div class="col-md-3">
                        <select id="staffType" class="js-example-basic-single"></select>
                    </div>
                    <div class="col-md-2 tar">
                        是否在编
                    </div>
                    <div class="col-md-3">
                        <select id="staffFlag" class="js-example-basic-single"></select>
                    </div>--%>
                      <div class="col-md-2 tar">
                          职称名称
                      </div>
                      <div class="col-md-3">
                          <input id="positional_titles" class="js-example-basic-single" type="text"></input>
                      </div>
                      <div class="col-md-2 tar">
                          职称级别
                      </div>
                      <div class="col-md-3">
                          <input id="positional_level" class="js-example-basic-single" type="text"></input>
                      </div>

                </div>
                <div class="form-row">
                    <%--<div class="col-md-2 tar">
                        签订合同情况
                    </div>
                    <div class="col-md-3">
                        <select id="contractType" class="js-example-basic-single"></select>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>人员状态
                    </div>
                    <div class="col-md-3">
                        <select id="staffStatus" class="js-example-basic-single"></select>
                    </div>--%>
                    <div class="col-md-2 tar">
                            备注
                    </div>
                        <div class="col-md-8">
                    <textarea id="remarkSel" style="height: 100px"
                              class="validate[required,maxSize[20]] form-control">
                              </textarea>
                        </div>
                </div>
               <%-- <div class="form-row">
                    <div class="col-md-2 tar">
                        用人形式
                    </div>
                    <div class="col-md-3">
                        <select id="employeForm" class="js-example-basic-single"></select>
                    </div>
                    <div class="col-md-2 tar">
                        信息技术应用能力
                    </div>
                    <div class="col-md-3">
                        <select id="technicalSkills" class="js-example-basic-single"></select>
                    </div>
                </div>--%>
               <%-- <div class="form-row">
                    <div class="col-md-2 tar">
                        是否双师型教师
                    </div>
                    <div class="col-md-3">
                        <select id="doubleTypeFlag" class="js-example-basic-single"></select>
                    </div>
                    <div class="col-md-2 tar">
                        是否具备职业技能等级证书
                    </div>
                    <div class="col-md-3">
                        <select id="credentialsFlag" class="js-example-basic-single"></select>
                    </div>
                </div>--%>
              <%--  <div class="form-row">
                    <div class="col-md-2 tar">
                        是否是特级教师
                    </div>
                    <div class="col-md-3">
                        <select id="stuntTeacherFlag" class="js-example-basic-single"></select>
                    </div>
                    <div class="col-md-2 tar">
                        企业工作(实践)时长
                    </div>
                    <div class="col-md-3">
                        <select id="workYear" class="js-example-basic-single"></select>
                    </div>
                </div>--%>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="testEvent()">读卡</button>
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="saveEmp()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<input id="deptId" type="text" hidden value="${deptId}">
<input id="dt" name="startdate"  type="text" hidden value=<%=new SimpleDateFormat("yyyy-MM-dd").format(new Date())%>></input>
<object id="plugin0" type="application/x-syncard" width="0" height="0">
    <param name="onload" value="pluginLoaded"/>
</object>
<script type="text/javascript">
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    var img;

    function plugin0() {
        return document.getElementById('plugin0');
    }

    plugin = plugin0;

    function addEvent(obj, name, func) {
        if (obj.attachEvent) {
            obj.attachEvent("on" + name, func);
        } else {
            obj.addEventListener(name, func, false);
        }
    }

    function testEvent() {
        plugin().SetReadType(0);
        plugin().ReadCard();
        //存参
        if (plugin().Name != null && plugin().Name != undefined && plugin().Name != "") {
            $("#name").val(plugin().Name)
            $("#idType").val("1")
            $("#idCard").val(plugin().CardNo)
            $("#sex").val(plugin().Sex)
            $("#nation").val(plugin().Nation)
            var birthday = plugin().Born
            $("#birthday").val(birthday.substring(0, 4) + "-" + birthday.substring(4, 6) + "-" + birthday.substring(6, 8))
            $("#photo").attr("src", "data:image/jpeg;base64," + plugin().Base64Photo)
            $("#address").val(plugin().Address)
            img = plugin().Base64Photo.replace("data:image/Jpeg;base64,", "");
        }
        /*var sex1 = plugin().Sex + "/" + plugin().SexL;
        var myElement1 = document.getElementById('ts101');
        myElement1.innerText = myElement1.textContent = sex1;
        var nation1 = plugin().Nation + "/" + plugin().NationL;
        var myElement2 = document.getElementById('ts201');
        myElement2.innerText = myElement2.textContent = nation1;
        var born1 = plugin().Born + "/" + plugin().BornL;
        var myElement3 = document.getElementById('ts301');
        myElement3.innerText = myElement3.textContent = born1;
        var address1 = plugin().Address;
        var myElement4 = document.getElementById('ts401');
        myElement4.innerText = myElement4.textContent = address1;
        var cardno1 = plugin().CardNo;
        var myElement5 = document.getElementById('ts501');
        myElement5.innerText = myElement5.textContent = cardno1;
        var police1 = plugin().Police;
        var myElement6 = document.getElementById('ts601');
        myElement6.innerText = myElement6.textContent = police1;
        var ustart1 = plugin().UserLifeB;
        var myElement7 = document.getElementById('ts701');
        myElement7.innerText = myElement7.textContent = ustart1;
        var uend1 = plugin().UserLifeE;
        var myElement8 = document.getElementById('ts801');
        myElement8.innerText = myElement8.textContent = uend1;
        var photoname1 = plugin().PhotoName;
        var myElement9 = document.getElementById('ts901');
        myElement9.innerText = myElement9.textContent = photoname1;
        var photobase = plugin().Base64Photo;
        var myElement10 = document.getElementById("image");
        myElement10.src = "data:image/jpeg;base64," + photobase;*/


        /*		    var state = plugin().NameL;
                    var myElement = document.getElementById('ts1001');
                    myElement.innerText = myElement.textContent = state;
        */
    }

    function pluginLoaded() {
        var CardState;
        PhotoSave();
        //开启自动读卡
        //AutoRead();
        addEvent(plugin(), 'OnStateChange', function (State) {
            CardState = plugin().State;
            if (CardState == 2) {
                $("#name").val(plugin().Name)
                /*myElement.innerText = myElement.textContent = namea1;
                var sex1 = plugin().Sex + "/" + plugin().SexL;
                var myElement1 = document.getElementById('ts101');
                myElement1.innerText = myElement1.textContent = sex1;
                var nation1 = plugin().Nation + "/" + plugin().NationL;
                var myElement2 = document.getElementById('ts201');
                myElement2.innerText = myElement2.textContent = nation1;
                var born1 = plugin().Born + "/" + plugin().BornL;
                var myElement3 = document.getElementById('ts301');
                myElement3.innerText = myElement3.textContent = born1;
                var address1 = plugin().Address;
                var myElement4 = document.getElementById('ts401');
                myElement4.innerText = myElement4.textContent = address1;
                var cardno1 = plugin().CardNo;
                var myElement5 = document.getElementById('ts501');
                myElement5.innerText = myElement5.textContent = cardno1;
                var police1 = plugin().Police;
                var myElement6 = document.getElementById('ts601');
                myElement6.innerText = myElement6.textContent = police1;
                var ustart1 = plugin().UserLifeB;
                var myElement7 = document.getElementById('ts701');
                myElement7.innerText = myElement7.textContent = ustart1;
                var uend1 = plugin().UserLifeE;
                var myElement8 = document.getElementById('ts801');
                myElement8.innerText = myElement8.textContent = uend1;
                var photoname1 = plugin().PhotoName;
                var myElement9 = document.getElementById('ts901');
                myElement9.innerText = myElement9.textContent = photoname1;
                var photobase = plugin().Base64Photo;
                var myElement10 = document.getElementById("image");
                myElement10.src = "data:image/jpeg;base64," + photobase;*/
                plugin().State = 0;// State=2代表读卡成功，由于不知道处理事件需要多长时间，因此成功之后
                                   // 就不再读卡，调用程序处理完成之后可以将State属性修改为0，插件将开始自动读卡
            }
        });
    }

    function AutoRead() {
        plugin().State = 0;
        plugin().SetReadType(1);
    }

    function StopAutoRead() {
        plugin().SetReadType(0);
    }

    function PhotoSave() {
        plugin().SetPhotoPath(2, "C:\\Users\\Public\\Documents");
    }
</script>

<script>
    var path = '<%=request.getContextPath()%>';
    $(document).ready(function () {
        addAdministrativeDivisions("nativePlaceProvince", "", "nativePlaceCity", "", "nativePlaceCounty", "", path);
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=MZ", function (data) {
            addOption(data, "nation");
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=GJ", function (data) {
            addOption(data, "nationality");
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=SFZJLX", function (data) {
            addOption(data, "idType");
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZZMM", function (data) {
            addOption(data, "politicalStatus");
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=HYZK", function (data) {
            addOption(data, "maritalStatus");
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XB", function (data) {
            addOption(data, 'sex');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=GW", function (data) {
            addOption(data, 'jobSel');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JKZK", function (data) {
            addOption(data, 'healthStatus');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JZGLY", function (data) {
            addOption(data, 'staffSource');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JZGLB", function (data) {
            addOption(data, 'staffType');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=YRXS", function (data) {
            addOption(data, 'employeForm');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=QDHTQK", function (data) {
            addOption(data, 'contractType');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XXJSYYNL", function (data) {
            addOption(data, 'technicalSkills');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=QYGZSC", function (data) {
            addOption(data, 'workYear');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JZGZT", function (data) {
            addOption(data, 'staffStatus');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JZGSS", function (data) {
            addOption(data, 'staffBelongs');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=SF", function (data) {
            addOption(data, 'sfzs');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=WHCD", function (data) {
            addOption(data, 'educational_level');
        });

        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JYFS", function (data) {
            addOption(data, 'education_technique');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=SF", function (data) {
            addOption(data, 'staffFlag');
            addOption(data, 'doubleTypeFlag');
            addOption(data, 'credentialsFlag');
            addOption(data, 'stuntTeacherFlag');
        });

        $("#idType").change(function () {
            if ($("#idType option:selected").val() != "") {
                $("#idTypeCode").html(" <span class='iconBtx'>*</span>"+$("#idType option:selected").text() + "号");
            }
        });
    });

    $("#staffBelongs").change(function () {
        var staffBelongsSHOW = $("#staffBelongs").val();
        if (staffBelongsSHOW == 1) {
            $.get("<%=request.getContextPath()%>/common/getSysDict?name=JZGLY2", function (data) {
                addOption(data, 'staffSource');
            });
        } else if (staffBelongsSHOW == 2) {
            $.get("<%=request.getContextPath()%>/common/getSysDict?name=JZGLY", function (data) {
                addOption(data, 'staffSource');
            });
        } else {
            $("#staffSource").html("<option value=''>请选择所属</option>")
        }
    });

    function saveEmp() {
        if ($("#name").val() == "" || $("#name").val() == null) {
            swal({
                title: "请填写人员姓名",
                type: "info"
            });
            //alert("请填写人员姓名");
            return;
        }
        if ($("#deptId").val() == "" || $("#deptId").val() == null) {
            swal({
                title: "请在左侧选择部门后再进行人员添加",
                type: "info"
            });
            //alert("请在左侧选择部门后再进行人员添加");
            return;
        }
        if ($("#jobSel option:selected").val() == "" || $("#jobSel option:selected").val() == null) {
            swal({
                title: "请选择岗位",
                type: "info"
            });
            //alert("请选择人员性别");
            return;
        }
        if ($("#sex option:selected").val() == "" || $("#sex option:selected").val() == null) {
            swal({
                title: "请选择人员性别",
                type: "info"
            });
            //alert("请选择人员性别");
            return;
        }

        if ($("#rz").val() == "" || $("#rz").val() == null) {
            swal({
                title: "请选择入职日期",
                type: "info"
            });
            //alert("请选择人员出生日期");
            return;
        }
       /* var myDate = new Date();
        var nowTime = myDate.getTime();*/

        if ($("#birthday").val() == "" || $("#birthday").val() == null) {
            swal({
                title: "请选择出生日期",
                type: "info"
            });
            return;
        }
        if ($("#dt").val() < $("#birthday").val()) {
            swal({
                title: "出生日期不可大于当前日期",
                type: "info"
            });
            return;
        }
        if ($("#idType option:selected").val() == "" || $("#idType option:selected").val() == null) {
            swal({
                title: "请选择证件类型",
                type: "info"
            });
            //alert("请选择人员性别");
            return;
        }
        if ($("#idCard").val() == "" || $("#idCard").val() == null) {
            swal({
                title: "请填写证件号码",
                type: "info"
            });
            //alert("请填写身份证号码");
            return;
        }
        var reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
        if ($("#idType option:selected").val() == '1' && reg.test($("#idCard").val()) === false) {
            swal({
                title: "身份证输入不合法",
                type: "info"
            });
            //alert("身份证输入不合法");
            return;
        }



        if ($("#tel").val() == "" || $("#tel").val() == null) {
            swal({
                title: "请填写联系方式",
                type: "info"
            });
            return;
        }

        if ($("#tel").val() != "") {
//            alert("请填写联系人电话");
//            return;
            var phoneNum = /^1\d{10}$/;
            var telNum = /^0\d{2,3}-[1-9]\d{6,7}$/ // /^0\d{2,3}-?\d{7,8}$/;
            if (phoneNum.test($("#tel").val()) === false && telNum.test($("#tel").val()) === false) {
                swal({
                    title: "联系人电话不正确",
                    type: "info"
                });
                //alert("联系人电话不正确");
                return;
            }
        }
       /* if ($("#staffId").val() == "" || $("#staffId").val() == null) {
            swal({
                title: "请填写教职工编号",
                type: "info"
            });
            return;
        }
        var reg = new RegExp("^[0-9]*$");
        if(!reg.test($("#staffId").val())){
            swal({
                title: "教职工编号请填写整数",
                type: "info"
            });
            return;
        }*/



        var toSchoolTime = new Date($("#toSchoolTime").val()).getTime();
        var workTime = new Date($("#workTime").val()).getTime();
       /* if (workTime == "") {
            swal({
                title: "请选择参加工作时间",
                type: "info"
            });
            return;
        }
        if (toSchoolTime == "") {
            swal({
                title: "请选择来校时间",
                type: "info"
            });
            return;
        }
        if (toSchoolTime < workTime) {
            swal({
                title: "参加工作时间不得晚于来校时间",
                type: "info"
            });
            return;
        }*/
       /* if ($("#staffStatus").val() == "" || $("#staffStatus").val() == null) {
            swal({
                title: "请选择人员状态",
                type: "info"
            });
            return;
        }*/

        $("#saveLoadingHeight").css('height','200px');
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/saveEmp", {
            name: $("#name").val(),
            deptId: $("#deptId").val(),
            idCard: $("#idCard").val(),
            nation: $("#nation option:selected").val(),
            sex: $("#sex option:selected").val(),
            birthday: $("#birthday").val(),
            address: $("#address").val(),
            tel: $("#tel").val(),
            nationality: $("#nationality option:selected").val(),
            staffId: $("#staffId").val(),
            /*usedName: $("#usedName").val(),*/
            idType: $("#idType option:selected").val(),
            nativePlaceProvince: $("#nativePlaceProvince option:selected").val(),
            nativePlaceCity: $("#nativePlaceCity option:selected").val(),
            nativePlaceCounty: $("#nativePlaceCounty option:selected").val(),
            birthPlace: $("#birthPlace").val(),
            politicalStatus: $("#politicalStatus option:selected").val(),
            maritalStatus: $("#maritalStatus option:selected").val(),
            healthStatus: $("#healthStatus option:selected").val(),
            workTime: $("#workTime").val(),
            toSchoolTime: $("#toSchoolTime").val(),
            staffSource: $("#staffSource option:selected").val(),
            staffType: $("#staffType option:selected").val(),
            staffFlag: $("#staffFlag option:selected").val(),
            employeForm: $("#employeForm option:selected").val(),
            contractType: $("#contractType option:selected").val(),
            technicalSkills: $("#technicalSkills option:selected").val(),
            doubleTypeFlag: $("#doubleTypeFlag option:selected").val(),
            credentialsFlag: $("#credentialsFlag option:selected").val(),
            stuntTeacherFlag: $("#stuntTeacherFlag option:selected").val(),
            workYear: $("#workYear option:selected").val(),
            staffStatus: $("#staffStatus option:selected").val(),
            staffBelongs: $("#staffBelongs option:selected").val(),
            job: $("#jobSel option:selected").val(),
            nativePlace: $("#jg").val(),
            entryDate: $("#rz").val(),
            permanentResidence: $("#hkszd").val(),
            permanentResidenceLocal: $("#hkszdqSel").val(),
            levels: $("#levelSel").val(),
            examinePolitical: $("#sfzs option:selected").val(),
            educationalLevel: $("#educational_level option:selected").val(),
            educationTechnique: $("#education_technique option:selected").val(),
            graduateSchool: $("#graduate_school").val(),
            graduateTime: $("#graduate_time").val(),
            major: $("#majorSel").val(),
            positionalTitles: $("#positional_titles").val(),
            positionalLevel:$("#positional_level").val(),
            remark:$("#remarkSel").val(),
            img: img

        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                //alert(msg.msg);
                $("#dialog").modal("hide");
                deptTable.ajax.reload();
            } else {
                swal({
                    title: msg.msg,
                    type: "success"
                });
            }
        })
    }
</script>