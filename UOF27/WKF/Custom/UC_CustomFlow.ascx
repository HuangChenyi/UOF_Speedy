<%@ Control Language="C#" AutoEventWireup="true" Inherits="WKF_Customer_UC_CustomFlow" CodeBehind="UC_CustomFlow.ascx.cs" %>

<%@ Reference Control="~/WKF/Custom/UC_CustomSite.ascx" %>
<%@ Reference Control="~/WKF/Custom/UC_CustomAlertSite.ascx" %>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr>
        <td align="center">
            <table cellpadding="0" cellspacing="0" width="100%" class="PopTable">
                <tr>
                    <td width="30%" style="height: 23px" class="PopTableLeftTD">
                        <asp:label id="lblFlowNameTitle" runat="server" text="流程名稱" meta:resourcekey="lblFlowNameTitleResource1"></asp:label>
                    </td>
                    <td width="70%" style="height: 23px" class="PopTableRightTD">
                        <table>
                            <tr>
                                <td>
                                    <asp:textbox id="tbxFlowName" runat="server" width="210px" meta:resourcekey="tbxFlowNameResource1"></asp:textbox>
                                    <asp:requiredfieldvalidator display="Dynamic"
                                        id="RequiredFieldValidator1" runat="server" errormessage="請輸入流程名稱" controltovalidate="tbxFlowName" meta:resourcekey="RequiredFieldValidator1Resource1">
                                    </asp:requiredfieldvalidator>
                                    &nbsp; &nbsp;
                                </td>
                                <td>
                                    <telerik:radbutton id="WebImageButton_SaveFlowName" runat="server" meta:resourcekey="WebImageButton_InsertFirstSiteResource1" onclick="WebImageButton_SaveFlowName_Click1"></telerik:radbutton>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td align="center" style="height: 80px" valign="top">
            <table border="0" cellpadding="0" cellspacing="0" style="width: 100%; height: 84px">
                <tr>
                    <td style="width: 33%; height: 70px"></td>
                    <td align="center" style="width: 12%; height: 70px" valign="top">
                        <asp:image id="Image2" runat="server" imageurl="~/Common/Images/Icon/icon_user.gif"
                            meta:resourcekey="Image2Resource1" />
                    </td>
                    <td style="width: 34%; height: 70px; text-align: left;" valign="bottom">&nbsp;
                        <telerik:radbutton id="WebImageButton_InsertFirstSite" runat="server"
                            meta:resourcekey="WebImageButton_InsertFirstSiteResource1" onclick="WebImageButton_InsertFirstSite_Click1">
                        </telerik:radbutton>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <asp:table id="tbSiteCollection" runat="server" meta:resourcekey="Table1Resource1"
                width="100%">
            </asp:table>
        </td>
    </tr>
</table>

<asp:label id="lblinsertConfirmStr" runat="server" meta:resourcekey="lblinsertConfirmStrResource1" text="確定新增站點?" visible="False"></asp:label>
<asp:label id="lblInsertFirstSite" runat="server" meta:resourcekey="lblInsertFirstSiteResource1" text="插入站點" visible="False"></asp:label>
<asp:label id="lblSaveFlow" runat="server" text="儲存" visible="False" meta:resourcekey="lblSaveFlowResource1"></asp:label>
<asp:label id="lblAddCustSiteMsg" runat="server" text="新增使用者自訂站點" visible="False" meta:resourcekey="lblAddCustSiteMsgResource1"></asp:label>
