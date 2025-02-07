using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;
using Ede.Uof.WKF.ExternalUtility;
using Training.UCO;

namespace Training.Trigger.DemoForm
{
    public class EndFormTrigger : ICallbackTriggerPlugin
    {
        public void Finally()
        {
            //  throw new NotImplementedException();
        }

        public string GetFormResult(ApplyTask applyTask)
        {
            // throw new NotImplementedException();

            //<Form formVersionId="30d33f52-802f-49b3-933e-f93a9c5d61cb">
            //  <FormFieldValue>
            //    <FieldItem fieldId="NO" fieldValue="" realValue="" />
            //    <FieldItem fieldId="A01" fieldValue="xxx" realValue="" fillerName="黃建龍" fillerUserGuid="07a00c72-270e-403e-b9df-20b530ba45e8" fillerAccount="Howard_Huang" fillSiteId="" />
            //    <FieldItem fieldId="A02" fieldValue="3" realValue="" fillerName="黃建龍" fillerUserGuid="07a00c72-270e-403e-b9df-20b530ba45e8" fillerAccount="Howard_Huang" fillSiteId="" />
            //    <FieldItem fieldId="A03" fieldValue="4" realValue="" fillerName="黃建龍" fillerUserGuid="07a00c72-270e-403e-b9df-20b530ba45e8" fillerAccount="Howard_Huang" fillSiteId="" />
            //    <FieldItem fieldId="A04" fieldValue="222" realValue="" fillerName="黃建龍" fillerUserGuid="07a00c72-270e-403e-b9df-20b530ba45e8" fillerAccount="Howard_Huang" fillSiteId="" />
            //  </FormFieldValue>
            //</Form>

            DemoUCO uco = new DemoUCO();
            string docNbr = applyTask.FormNumber;
            string signStatus = applyTask.FormResult.ToString();

            uco.UpdateFormResult(docNbr, signStatus);


            if(applyTask.FormResult == Ede.Uof.WKF.Engine.ApplyResult.Adopt)
            {
                string formInfo = GetFormInfo(applyTask);

                Ede.Uof.WKF.Utility.TaskUtilityUCO taskUCO = new Ede.Uof.WKF.Utility.TaskUtilityUCO();
                string result= taskUCO.WebService_CreateTask(formInfo);

                XElement resultXE = XElement.Parse(result);

                if(resultXE.Element("Status").Value == "0")
                {
                    string error = $@"formInfo:{formInfo}
Message:{resultXE.Element("Exception").Element("Message").Value}
Type:{resultXE.Element("Exception").Element("Type").Value}";
                       
                    throw new Exception(error);
                      
                }

            }

            return "";
        }

        private string GetFormInfo(ApplyTask applyTask)
        {
            var fields = applyTask.Task.CurrentDocument.Fields;
            var applicant= applyTask.Task.Applicant;
            string type = "";

            string item = fields["A01"].FieldValue;

            string amount = fields["A02"].FieldValue;

            XElement formXE = new XElement("Form", new XAttribute("formVersionId", "f8203845-cb26-40a9-b39c-c907500e4841"), new XAttribute("urgentLevel", "2"));
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
                , new XAttribute("taskGuid",applyTask.TaskId));

            fieldItemrefFormXE.Add(FormChooseInfoXE);

            formXE.Add(applicantXE);
            formXE.Add(formFieldValueXE);

            applicantXE.Add(commentXE);

            formFieldValueXE.Add(fieldItemNoXE, fieldItemTypeXE, fieldItemITemXE, fieldItemAmountXE, fieldItemrefFormXE);
            return formXE.ToString();
        }

        public void OnError(Exception errorException)
        {
          
        }
    }
}
