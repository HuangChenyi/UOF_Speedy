<%@ Page Title="匯入部門代碼" Language="C#" MasterPageFile="~/Master/DialogMasterPage.master" AutoEventWireup="true" CodeBehind="ImportDeptData.aspx.cs" Inherits="Ede.Uof.Web.HR104.SyncHR.ImportDeptData" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>

<%@ Register Src="~/Common/FileCenter/V3/UC_FileCenter.ascx" TagPrefix="uc1" TagName="UC_FileCenter" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table class="PopTable" style="width: 100%">
        <tr>
            <td style=" white-space:nowrap;">
                <asp:Label ID="Label2" runat="server" Text="*" ForeColor="Red" meta:resourcekey="Label2Resource1"></asp:Label>
                <asp:Label ID="Label1" runat="server" Text="選擇匯入檔案" meta:resourcekey="Label1Resource1"></asp:Label>
            </td>
            <td>
                <uc1:UC_FileCenter runat="server" ID="UC_FileCenter" />
                <asp:Label ID="Label3" runat="server" Text="匯入的檔案請從匯出取得" CssClass="SizeMemo" meta:resourcekey="Label3Resource1"></asp:Label>
            </td>
        </tr>
        </table>
        <asp:Label ID="lblImportFail" runat="server" ForeColor="Red" Text="匯入失敗" Visible="False" meta:resourcekey="lblImportFailResource1"></asp:Label>
        <asp:Label ID="lblImportCompleted" runat="server" ForeColor="Blue" Text="匯入完成" Visible="False" meta:resourcekey="lblImportCompletedResource1"></asp:Label>
        <asp:TextBox ID="txtMsg" runat="server" TextMode="MultiLine" Width="100%" Rows="5" Visible="False" meta:resourcekey="txtMsgResource1"></asp:TextBox>
        <asp:Label ID="lblFormateErrorMsg" runat="server" Text="匯入檔案格式錯誤，請重新上傳！" Visible="False" meta:resourcekey="lblFormateErrorMsgResource1"></asp:Label>
        <asp:Label ID="lblDeptCodeExistError" runat="server" Text="部門代碼不允許重複" Visible="False" meta:resourcekey="lblDeptCodeExistErrorResource1"></asp:Label>
        <asp:Label ID="lblDeptEmptyError" runat="server" Text="部門不允許空白" Visible="False" meta:resourcekey="lblDeptEmptyErrorResource1"></asp:Label>
        <asp:Label ID="lblCompanyCodeDupError" runat="server" Text="公司層部門代碼({0})重複，請確認匯入的EXCEL資料設定正確。" Visible="False" meta:resourcekey="lblCompanyCodeDupErrorResource1"></asp:Label>
        <asp:Label ID="lblCorpCodeError" runat="server" Text="當有啟用多公司別時，集團的部門代碼需為空白，請確認匯入的EXCEL資料設定正確。" Visible="False" meta:resourcekey="lblCorpCodeErrorResource1"></asp:Label>
        <asp:Label ID="lblCompanyCodeNotExist" runat="server" Visible="False" Text="[{0}]的公司層部門代碼，不存在104系統。" meta:resourcekey="lblCompanyCodeNotExistResource1"></asp:Label>
        <asp:Label ID="lblCompanyCodeUpdated" runat="server" Visible="False" Text="[{0}]的公司層部門代碼已依104設定更新成{1}。" meta:resourcekey="lblCompanyCodeUpdatedResource1"></asp:Label>
        <asp:Label ID="lblFileNotParse" runat="server" Visible="False" Text="匯入的檔案無法解析" meta:resourcekey="lblFileNotParseResource1"></asp:Label>
        
</asp:Content>
