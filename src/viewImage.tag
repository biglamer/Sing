<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib tagdir="/WEB-INF/tags/util" prefix="util" %>
<%@ taglib tagdir="/WEB-INF/tags/dialog" prefix="dialog"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ attribute name="avatarId" required="true" rtexprvalue="true" type="java.lang.Long" %>
<%@ attribute name="performerId" required="true" rtexprvalue="true" type="java.lang.Long" %>

<c:url var="documentDownloadUrl" value="/document/" />
<c:url var="uploadURL" value="/document/performer/${performerId}/image/upload.html" />
<c:url var="deleteURL" value="/document/performer/${performerId}/image/delete.html" />
 <c:url value="/images/32x32/user_gomer.png" var="onErrorImg"/>
 <sec:authorize access="hasAnyRole('customer_admin','performer_admin')">
 <script>
 $(function() {
    
        // При наведении на ссылку
        $("#uploadImageDropZone").mouseover(function(){
         var urlSrcImage=$('#mainImage').attr('src');
           if(urlSrcImage.indexOf("${onErrorImg}")==-1){
             $("#divDelete").show();
           }
        });
        $("#uploadImageDropZone").mouseout(function(){
                $("#divDelete").hide();
           });
        
        $("#divDelete").click(function(){
          deleteImage();
        }); 
       
    function deleteImage() {
            var requestUrl = "${deleteURL}";
            $.ajax({
                type: "POST",
                url: requestUrl,
                success: function() {
                  var src="${onErrorImg}";
                  toastr.info('<spring:message code="performer.logo.delete" />');
                   $('#mainImage').attr('src',src);
                   $("#divDelete").hide();
                    }, 
                error: function(error) {showError(error.responseText);}
            });
        }
    });
</script>
 <script type="text/javascript">
$(function() {

    $("#fileUploadImage").fileupload({
        dataType: 'json',
        dropZone: $('#uploadImageDropZone'),
        add: function (e, data) {
           $("#divProgress").show();
            data.url = "${uploadURL}";
            data.submit();
        },
        progress: function(e, data) {
          $('#divProgress progress').val(parseInt(data.loaded / data.total * 100, 10));
        },
        fail: function (e, data) {
            data.context.remove();
            toastr.error('<spring:message code="server.error" />: ' + data.textStatus);
        },
        done: function (e, data) {
         var src="${documentDownloadUrl}"+data.result.id+ "/download.html";
           $('#mainImage').attr('src',src);
           $("#divProgress").hide();
           $("#divDelete").show();
            toastr.info('<spring:message code="performer.logo.uploaded" />');
        }
    });
    
});
</script> 
</sec:authorize>
  <div id="uploadImageDropZone">
            <div>
               <input id="fileUploadImage" name="file" type="file" style="display: none"/>
            </div>
             <div id="divDelete" class="delete-btn" title="<spring:message code="template.documents.delete" />" style="display: none; position:absolute;z-index:2;"></div>
             <div>
               <c:set value="${onErrorImg}" var="urlImg"/>
             <c:if test="${not empty avatarId&& avatarId ne 0}">
                <c:set value="${documentDownloadUrl}${avatarId}/download.html" var="urlImg"/>
              </c:if>
              <spring:message code="performer.logo" var="logoVar"/>
              <img src="${urlImg}" alt="${logoVar}" title="${logoVar}" id="mainImage" width="200" height="200" style="border: 2px solid #d5d5d5;" onerror="this.src='${onErrorImg}';"/>
             </div >
             <div id="divProgress" style="display: none">
              <progress max="100" value="0"></progress>
             </div>
   </div>