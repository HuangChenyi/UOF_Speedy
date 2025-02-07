using Ede.Uof.EIP.Organization.Util;
using Ede.Uof.WKF.ExternalUtility;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;
using Training.UCO;

namespace Training.Trigger.DemoForm
{
    public class SendFormSignTrigger : Ede.Uof.WKF.ExternalUtility.ICallbackTriggerPlugin
    {
        public void Finally()
        {
          //  throw new NotImplementedException();
        }

        public string GetFormResult(ApplyTask applyTask)
        {
            //<Form formVersionId="910a6cb8-c380-436c-aff3-4f7c520d0632">
            //  <FormFieldValue>
            //    <FieldItem fieldId="NO" fieldValue="" realValue="" enableSearch="True" />
            //    <FieldItem fieldId="A05" fieldValue="Mary(Mary)、HR(HR)" realValue="&lt;UserSet&gt;&lt;Element type='user'&gt; &lt;userId&gt;cd2f2e14-8a74-45a5-a667-4f91b21460bc&lt;/userId&gt;&lt;/Element&gt;&lt;Element type='user'&gt; &lt;userId&gt;335af80b-a806-436d-b5e5-b463ef3ef01f&lt;/userId&gt;&lt;/Element&gt;&lt;/UserSet&gt;&#xD;&#xA;" enableSearch="True" fillerName="Tony" fillerUserGuid="c496e32b-0968-4de5-95fc-acf7e5a561c0" fillerAccount="Tony" fillSiteId="" />
            //    <FieldItem fieldId="A01" fieldValue="33" realValue="" enableSearch="True" fillerName="Tony" fillerUserGuid="c496e32b-0968-4de5-95fc-acf7e5a561c0" fillerAccount="Tony" fillSiteId="" />
            //    <FieldItem fieldId="A02" fieldValue="3" realValue="" enableSearch="True" fillerName="Tony" fillerUserGuid="c496e32b-0968-4de5-95fc-acf7e5a561c0" fillerAccount="Tony" fillSiteId="" />
            //    <FieldItem fieldId="A03" fieldValue="3" realValue="" enableSearch="True" fillerName="Tony" fillerUserGuid="c496e32b-0968-4de5-95fc-acf7e5a561c0" fillerAccount="Tony" fillSiteId="" />
            //    <FieldItem fieldId="A04" fieldValue="" realValue="" enableSearch="True" />
            //  </FormFieldValue>
            //</Form>

            if(applyTask.SignResult == Ede.Uof.WKF.Engine.SignResult.Approve)
            {
         
                string a05RealValue = applyTask.Task.CurrentDocument.Fields["A05"].RealValue;

                UserSet userSet = new UserSet();
                userSet.SetXML(a05RealValue);

                DataTable dt = userSet.GetAllUsers();

                foreach (DataRow dr in dt.Rows)
                {
                    string formInfo = GetFormInfo(applyTask, dr["USER_GUID"].ToString());

                    Ede.Uof.WKF.Utility.TaskUtilityUCO taskUCO = new Ede.Uof.WKF.Utility.TaskUtilityUCO();
                    string result = taskUCO.WebService_CreateTask(formInfo);

                    XElement resultXE = XElement.Parse(result);

                    if (resultXE.Element("Status").Value == "0")
                    {
                        string error = $@"formInfo:{formInfo}
Message:{resultXE.Element("Exception").Element("Message").Value}
Type:{resultXE.Element("Exception").Element("Type").Value}";

                        throw new Exception(error);

                    }
                }

               
            }

            return "";
          //  throw new NotImplementedException();
        }

        private string GetFormInfo(ApplyTask applyTask, string userGuid)
        {
            DemoUCO uco = new DemoUCO();
            var fields = applyTask.Task.CurrentDocument.Fields;
            var applicant = applyTask.Task.Applicant;
            string type = "";
            string formVerionId = uco.GetUsingVerionId("LabForm");
            string item = fields["A01"].FieldValue;

            string amount = fields["A02"].FieldValue;

            XElement formXE = new XElement("Form", new XAttribute("formVersionId", formVerionId), new XAttribute("urgentLevel", "2"));
            XElement applicantXE = new XElement("Applicant", new XAttribute("account", applicant.Account)
                , new XAttribute("groupId", ""), new XAttribute("jobTitleId", ""));

            XElement commentXE = new XElement("Comment", "");

            XElement formFieldValueXE = new XElement("FormFieldValue");

            XElement fieldItemNoXE = new XElement("FieldItem", new XAttribute("fieldId", "NO")
                , new XAttribute("fieldValue", "")
                , new XAttribute("IsNeedAutoNbr", "false"));

            XElement fieldItemTypeXE = new XElement("FieldItem", new XAttribute("fieldId", "type")
                , new XAttribute("fieldValue", type));

            XElement fieldItemITemXE = new XElement("FieldItem", new XAttribute("fieldId", "item")
                , new XAttribute("fieldValue", item));

            XElement fieldItemAmountXE = new XElement("FieldItem", new XAttribute("fieldId", "amount")
              , new XAttribute("fieldValue", amount));

            XElement fieldItemrefFormXE = new XElement("FieldItem", new XAttribute("fieldId", "RefForm")
  , new XAttribute("ConditionValue", "")
   , new XAttribute("realValue", ""));

            XElement FormChooseInfoXE = new XElement("FormChooseInfo"
                , new XAttribute("taskGuid", applyTask.TaskId));

            fieldItemrefFormXE.Add(FormChooseInfoXE);

            UserUCO userUCO = new UserUCO();
            EBUser user = userUCO.GetEBUser(userGuid);

            UserSet userSet = new UserSet();
            UserSetUser userSetUser = new UserSetUser();
            userSetUser.USER_GUID = userGuid;

            userSet.Items.Add(userSetUser);
            XElement fieldItemOwnerXE = new XElement("FieldItem", new XAttribute("fieldId", "owner")
, new XAttribute("fieldValue", $"{user.Name}({user.Account})")
, new XAttribute("realValue", userSet.GetXML()));

            formXE.Add(applicantXE);
            formXE.Add(formFieldValueXE);

            applicantXE.Add(commentXE);

            formFieldValueXE.Add(fieldItemNoXE, fieldItemTypeXE, fieldItemITemXE, fieldItemAmountXE, fieldItemrefFormXE, fieldItemOwnerXE);
            return formXE.ToString();
        }

        public void OnError(Exception errorException)
        {
           // throw new NotImplementedException();
        }
    }
}
