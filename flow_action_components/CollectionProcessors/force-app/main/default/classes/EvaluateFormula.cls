global with sharing class EvaluateFormula {
   
    @InvocableMethod
    global static List <Results> evaluate (List<Requests> requestList) {
        System.debug('entering Evaluate Formula');


        String formulaString = requestList[0].formulaString;
        String contextDataString = requestList[0].contextDataString;
       
        //the parser currently can't handle a null value
        if (contextDataString == null)
            contextDataString = '[]';

        String result = FormulaEvaluator.parseFormula(formulaString, contextDataString);
       //TO DO: need to fix this to return non-integer values effectively. we may need to pass in an indicator as to what
       //what the input type is
	 
        //Create a Results object to hold the return values
        Results response = new Results();
        response.stringResult = result;

        //Wrap the Results object in a List container (an extra step added to allow this interface to also support bulkification)
        List<Results> responseWrapper= new List<Results>();
        responseWrapper.add(response);
        System.debug('response is: '+ response);
        System.debug('responseWrapper is: '+ responseWrapper);

        return responseWrapper;
    
    }

    

    global  class Requests {
       
      @InvocableVariable
      global String formulaString;

       @InvocableVariable
      global String contextDataString;
        
    }
    
    global  class Results {

     
      @InvocableVariable
      global String stringResult;

      @InvocableVariable
      global Decimal numberResult;


        }
}