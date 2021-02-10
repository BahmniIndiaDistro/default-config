Bahmni.ConceptSet.FormConditions.rules = {
    'Diastolic Data' : function (formName, formFieldValues) {
        var systolic = formFieldValues['Systolic'];
        var diastolic = formFieldValues['Diastolic'];
        if (systolic || diastolic) {
            return {
                enable: ["Posture"]
            }
        } else {
            return {
                disable: ["Posture"]
            }
        }
    },
    'Systolic Data' : function (formName, formFieldValues) {
        var systolic = formFieldValues['Systolic'];
        var diastolic = formFieldValues['Diastolic'];
        if (systolic || diastolic) {
            return {
                enable: ["Posture"]
            }
        } else {
            return {
                disable: ["Posture"]
            }
        }
    },
    'Eligible for Vaccine': function (formName, formFieldValues) {
        var eligibleValue = formFieldValues['Eligible for Vaccine'];
        if (eligibleValue == 'False') {
            var reasons = formFieldValues["COVID-19-Starter, Reason for not eligible for vaccine"];
            var showList = ["COVID-19-Starter, Reason for not eligible for vaccine"];

            return {
                show: showList
            }
        } else {
            return {
                hide: ["COVID-19-Starter, Reason for not eligible for vaccine", "Currently taking medication", "COVID-19-Starter, Others"]
            }
        }
    },
    'COVID-19-Starter, Reason for not eligible for vaccine': function (formName, formFieldValues) {
        var reasons = formFieldValues["COVID-19-Starter, Reason for not eligible for vaccine"];
        var showList = [];
        var hideList = [];

        var showMed = false;
        var showOthers = false;

        for (i = 0; i < reasons.length; i++) {
            if (reasons[i] == 'Currently taking medication') {
                showMed = true;
                showList.push("Currently taking medication");
            } else if (reasons[i] == 'COVID-19-Starter, Others') {
                showOthers = true;
                showList.push("COVID-19-Starter, Others");
            }
        }
        if (!showOthers) {
            hideList.push("COVID-19-Starter, Others");
        }
        if (!showMed) {
            hideList.push("Currently taking medication");
        }

        return {
            show: showList,
            hide: hideList
        }
    },
   'COVID-19-Starter, New symptoms since vaccination': function (formName, formFieldValues) {
        var newSymptomsValue = formFieldValues['COVID-19-Starter, New symptoms since vaccination'];
        console.log(newSymptomsValue);
        if (newSymptomsValue == 'True') {
            var showList = ["COVID-19-Starter, Side effects reported after vaccination"];

            return {
                show: showList
            }
        } else {
            return {
                hide: ["COVID-19-Starter, Side effects reported after vaccination"]
            }
        }
    },
    'COVID-19-Starter, Symptoms': function (formName, formFieldValues) {
        var reasons = formFieldValues["COVID-19-Starter, Symptoms"];
        var showList = [];
        var hideList = [];

        var showOthers = false;

        for (i = 0; i < reasons.length; i++) {
           if (reasons[i] == 'COVID-19-Starter, Other') {
                showOthers = true;
                showList.push("COVID-19-Starter, Other");
            }
        }
        if (!showOthers) {
            hideList.push("COVID-19-Starter, Other");
        }

        return {
            show: showList,
            hide: hideList
        }
    }
};