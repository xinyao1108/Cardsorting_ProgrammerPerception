import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.opencsv.CSVReader;
import com.opencsv.exceptions.CsvValidationException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;

@SuppressWarnings("serial")
@WebServlet(name = "StudyInformationSheet", urlPatterns = {"/StudyInformationSheet"})
public class StudyInformationSheet extends HttpServlet {

	String homPath = "";
	
    // Initialize the all the attributes, read and store cards, and generate card orders 
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
				
				HttpSession session = request.getSession(true);
				if(session.getAttribute("SIS") == null){
					//read form fields and store consent
					String consent = request.getParameter("formStudyInformationSheetConsent");
					session.setAttribute("consent",consent);
                    session.setAttribute("SIS",1);
                    session.setAttribute("radioBtnAnswers","");
                    session.setAttribute("radioBtnPage",-1);
                    
                    session.setAttribute("ProlificID",0);
                    session.setAttribute("ReceivedID",0);

                    session.setAttribute("Instructions1",0);

                    session.setAttribute("CardSortingStatus",0);
                    session.setAttribute("CardSortingReason",0);
                    session.setAttribute("ValidationFail",0);
					
                    String cardNames = this.getServletContext().getRealPath("Cards/Cards.csv");
					ArrayList<Card> cards = ReadCards(cardNames);
                    session.setAttribute("Cards",cards);
                    
                    session.setAttribute("CardOrder",getCardOrder(cards.size()));
                    session.setAttribute("CurrentCard",0);

					response.sendRedirect("prolificID.jsp");
				}else{
					response.sendRedirect("prolificID.jsp");
				}
    }
    
    private ArrayList<Integer> getCardOrder(int length){
        ArrayList<Integer> index_list = new ArrayList<Integer>();
        for(int i=0; i < length; i++){
            index_list.add(i);
        }
        Collections.shuffle(index_list);
        return index_list;
    }
    
	
	private ArrayList<Card> ReadCards(String filename) throws IOException{
        CSVReader reader = new CSVReader (new FileReader(filename));
        ArrayList<Card> cards = new ArrayList<Card>();
        try{
            reader.skip(1);
            for(String[] line = reader.readNext(); line != null; line = reader.readNext() ){
                Logger logger = Logger.getLogger(this.getClass().getName());
                logger.log(Level.INFO, line[0]);
                String cardName = line[0];
                String cardDescription = line[1];
                // String category = line[2];
                
                cards.add(new Card(cardName,cardDescription));
            }
        }catch(CsvValidationException e){
        	Logger logger = Logger.getLogger(this.getClass().getName());
            logger.log(Level.WARNING, e.getMessage());
            
            return cards;
        }
        return cards;
    }
	
}