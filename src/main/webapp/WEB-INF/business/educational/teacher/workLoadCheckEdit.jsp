<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link href="/libs/css/stylesheets.css" rel="stylesheet" type="text/css">
<div class="modal-dialog" style="width: 60%;">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px;">${head}</span>
            <input id="teacherId" hidden value="${array.teacherId}"/>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-2 tar">
                        教师姓名
                    </div>
                    <div class="col-md-4">
                        <input id="teacherInfoName" type="text" value="${array.teacherNameShow}"/>
                        <input id="perId" type="hidden" value="${array.teacherName}"/>
                    </div>
                    <div class="col-md-2 tar">
                        学期
                    </div>
                    <div class="col-md-4">
                        <select id="term" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        系部
                    </div>
                    <div class="col-md-4">
                        <select id="departmentSub" />
                    </div>
                    <div class="col-md-2 tar">
                        专业
                    </div>
                    <div class="col-md-4">
                        <select id="majorSub"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        教学授课情况
                    </div>
                    <div class="col-md-4">
                        <input id="teachingSituation" value="${array.teachingSituation}" type="text"/>
                    </div>
                    <div class="col-md-2 tar">
                        教学授课情况课时数
                    </div>
                    <div class="col-md-4">
                        <input id="hours" value="${array.hours}"   type="text" value="${array.hours}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        竞赛辅导班级
                    </div>
                    <div class="col-md-4">
                        <input id="raceClass" value="${array.raceClass}" type="text"/>
                    </div>
                    <div class="col-md-2 tar">
                        竞赛辅导班级人数
                    </div>
                    <div class="col-md-4">
                        <input id="raceClassNum" value="${array.raceClassNum}" type="text"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        竞赛辅导班级内容
                    </div>
                    <div class="col-md-4">
                        <input id="raceClassContent" value="${array.raceClassContent}" type="text"/>
                    </div>
                    <div class="col-md-2 tar">
                        竞赛辅导班课时数
                    </div>
                    <div class="col-md-4">
                        <input id="raceHours" value="${array.raceHours}" type="text"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        讲座班级
                    </div>
                    <div class="col-md-4">
                        <input id="lectureClass" value="${array.lectureClass}" type="text"/>
                    </div>
                    <div class="col-md-2 tar">
                        讲座班级人数
                    </div>
                    <div class="col-md-4">
                        <input id="lectureClassNum" value="${array.lectureClassNum}" type="text"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        讲座班级内容
                    </div>
                    <div class="col-md-4">
                        <input id="lectureClassContent" value="${array.lectureClassContent}" type="text"/>
                    </div>
                    <div class="col-md-2 tar">
                        讲座班级课时数
                    </div>
                    <div class="col-md-4">
                        <input id="lectureClassHours" value="${array.lectureClassHours}" type="text"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        教学秘书课时数
                    </div>
                    <div class="col-md-4">
                        <input id="teachingSecretariesHours" value="${array.teachingSecretariesHours}" type="text"/>
                    </div>
                    <div class="col-md-2 tar">
                        其他工作内容
                    </div>
                    <div class="col-md-4">
                        <input id="otherContent" value="${array.otherContent}" type="text"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        其他工作课时数
                    </div>
                    <div class="col-md-4">
                        <input id="otherHours" value="${array.otherHours}" type="text"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="save()">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<script type="text/javascript" src="../../../libs/js/plugins/ztree/jquery.ztree.core.js"></script>
<script type="text/javascript" src="../../../libs/js/plugins/ztree/jquery.ztree.excheck.js"></script>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        var id = $("#teacherId").val();
        });
    $.get("<%=request.getContextPath()%>/common/getSelectDept?type=8", function (data) {
        addOption(data, 'departmentSub', '${array.departmentsId}');
    });
    $.get("<%=request.getContextPath()%>/common/getTableDict", {
            id: " major_id",
            text: " major_name ",
            tableName: "t_xg_major",
            where: " where  major_name is not  null",
            orderby: " "
        },
        function (data) {
            var majorCodeLevel='${array.major}';
            var majorCode = majorCodeLevel.split(",")[0];
            addOption(data, "majorSub",majorCode);
        });
    $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
        addOption(data, 'term','${array.term}');
    });
    if(""!='${array.major}'){
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " major_id",
                text: " major_name ",
                tableName: "t_xg_major",
                where: " where  major_name is not  null",
                orderby: " "
            },
            function (data1) {
                addOption(data1, "majorSub", '${array.major}');
            })
    }
    $("#departmentSub").change(function() {
        if($("#departmentSub").val()!=""){
            $.get("<%=request.getContextPath()%>/common/getTableDict",{
                    id: " distinct id ",
                    text: " name ",
                    tableName: " (select  MAJOR_CODE||','||TRAINING_LEVEL as id ," +
                    " MAJOR_NAME||' -- '||FUNC_GET_DICVALUE(TRAINING_LEVEL,'ZXZYPYCC') as name " +
                    "from T_XG_MAJOR where 1 = 1 and DEPARTMENTS_ID = '"+$("#departmentSub").val()+"'  ) ",
                    where: " ",
                    orderby: " "
                },
                function (data1) {
                    addOption(data1, "majorSub", '${array.major}');
                })
        }
    });
    $.get("<%=request.getContextPath()%>/stamp/autoCompleteEmployee", function (data) {
        $("#teacherInfoName").autocomplete({
            source: data,
            select: function (event, ui) {
                $("#teacherInfoName").val(ui.item.label);
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
    function save() {
        var reg1 = /^[0-9]+.?[0-9]*$/;
        var teacherId=$("#teacherId").val();
        var term = $("#term").val();
        var departmentsId = $("#departmentSub").val();
        var major = $("#majorSub").val();
        var teacherInfoName = $("#teacherInfoName").val();
        var hours = $("#hours").val();
        var raceHours = $("#raceHours").val();
        var lectureHours = $("#lectureHours").val();
        var teachingSecretariesHours = $("#teachingSecretariesHours").val();
        var otherHours = $("#otherHours").val();
        var teachingSituation = $("#teachingSituation").val();
        var raceClass = $("#raceClass").val();
        var raceClassNum = $("#raceClassNum").val();
        var raceClassContent = $("#raceClassContent").val();
        var lectureClass = $("#lectureClass").val();
        var lectureClassNum = $("#lectureClassNum").val();
        var lectureClassContent = $("#lectureClassContent").val();
        var lectureClassHours = $("#lectureClassHours").val();
        var otherContent = $("#otherContent").val();
        if($("#perId").val()=="" || $("#perId").val() == undefined || $("#perId").val() == null){
            swal({
                title: "请填写教师姓名！",
                type: "info"
            });
            return;
        }
        if(term=="" || term == undefined || term == null){
            swal({
                title: "请填写学期！",
                type: "info"
            });
            return;
        }
        if(departmentsId=="" || departmentsId == undefined || departmentsId == null){
            swal({
                title: "请填写系部！",
                type: "info"
            });
            return;
        }
        if(major=="" || major == undefined || major == null){
            swal({
                title: "请填写专业！",
                type: "info"
            });
            return;
        }
        if(teachingSituation=="" || teachingSituation == undefined || teachingSituation == null){
            swal({
                title: "请填写教学授课情况！",
                type: "info"
            });
            return;
        }
        if(hours=="" || hours == undefined || hours == null){
            swal({
                title: "请填写教学授课情况课时数！",
                type: "info"
            });
            return;
        }
        if(!reg1.test(hours)){
            swal({
                title: "教学授课情况课时数请填写数字！",
                type: "info"
            });
            return;
        }
        if(raceClass=="" || raceClass == undefined || raceClass == null){
            swal({
                title: "请填写竞赛辅导班级！",
                type: "info"
            });
            return;
        }
        if(raceClassNum=="" || raceClassNum == undefined || raceClassNum == null){
            swal({
                title: "请填写竞赛辅导班级人数！",
                type: "info"
            });
            return;
        }
        if(!reg1.test(raceClassNum)){
            swal({
                title: "竞赛辅导班级人数请填写数字！",
                type: "info"
            });
            return;
        }
        if(raceClassContent=="" || raceClassContent == undefined || raceClassContent == null){
            swal({
                title: "请填写竞赛辅导班级内容！",
                type: "info"
            });
            return;
        }
        if(raceHours=="" || raceHours == undefined || raceHours == null){
            swal({
                title: "请填写竞赛辅导班课时数！",
                type: "info"
            });
            return;
        }
        if(!reg1.test(raceHours)){
            swal({
                title: "竞赛辅导班课时数请填写数字！",
                type: "info"
            });
            return;
        }
        if(lectureClass=="" || lectureClass == undefined || lectureClass == null){
            swal({
                title: "请填写讲座班级！",
                type: "info"
            });
            return;
        }
        if(lectureClassNum=="" || lectureClassNum == undefined || lectureClassNum == null){
            swal({
                title: "请填写讲座班级人数！",
                type: "info"
            });
            return;
        }
        if(!reg1.test(lectureClassNum)){
            swal({
                title: "讲座班级人数请填写数字！",
                type: "info"
            });
            return;
        }
        if(lectureClassContent=="" || lectureClassContent == undefined || lectureClassContent == null){
            swal({
                title: "请填写讲座班级内容！",
                type: "info"
            });
            return;
        }
        if(lectureClassHours=="" || lectureClassHours == undefined || lectureClassHours == null){
            swal({
                title: "请填写讲座班级课时数！",
                type: "info"
            });
            return;
        }
        if(!reg1.test(lectureClassHours)){
            swal({
                title: "讲座班级课时数请填写数字！",
                type: "info"
            });
            return;
        }
        if(teachingSecretariesHours=="" || teachingSecretariesHours == undefined || teachingSecretariesHours == null){
            swal({
                title: "请填写教学秘书课时数！",
                type: "info"
            });
            return;
        }
        if(!reg1.test(teachingSecretariesHours)){
            swal({
                title: "教学秘书课时数请填写数字！",
                type: "info"
            });
            return;
        }
        if(otherContent=="" || otherContent == undefined || otherContent == null){
            swal({
                title: "请填写其他工作内容！",
                type: "info"
            });
            return;
        }
        if(otherHours=="" || otherHours == undefined || otherHours == null){
            swal({
                title: "请填写其他工作内容课时数！",
                type: "info"
            });
            return;
        }
        if(!reg1.test(otherHours)){
            swal({
                title: "其他工作内容课时数请填写数字！",
                type: "info"
            });
            return;
        }
        if($("#teacherInfoName").attr("keycode")=="" || $("#teacherInfoName").attr("keycode") ==null){
            $("#teacherInfoName").attr("keycode",$("#perId").val())
        }
        $.post("<%=request.getContextPath()%>/workLoadCheck/save", {
            teacherId: teacherId,
            term:term,
            departmentsId:departmentsId,
            major:major,
            teacherName:$("#teacherInfoName").attr("keycode"),
            hours:hours,
            raceHours:raceHours,
            lectureHours:lectureHours,
            teachingSecretariesHours:teachingSecretariesHours,
            otherHours:otherHours,
            teachingSituation:teachingSituation,
            raceClass: raceClass,
            raceClassNum: raceClassNum,
            raceClassContent: raceClassContent,
            lectureClass: lectureClass,
            lectureClassNum:lectureClassNum,
            lectureClassContent: lectureClassContent,
            lectureClassHours:lectureClassHours,
            otherContent:otherContent,
        }, function (msg) {
            swal({title: msg.msg, type: "success"});
            $("#dialog").modal('hide');
            $('#toResultTeacherTable').DataTable().ajax.reload();
        })

    }
    function changeMajor() {
            var deptId = $("#departmentSub").val();
            $.get("<%=request.getContextPath()%>/common/getMajorByDeptId?deptId=" + deptId, function (data) {
                addOption(data, 'majorSub');
            });
    }
</script>

<style>
    #menuContent{
        display:none;
        position: absolute;
        left: 10px !important;
        top: 31px !important;
        background: #ffffff;
        z-index: 9999999;
    }
</style>
