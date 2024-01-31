import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.google.gson.Gson; 
import com.google.gson.GsonBuilder; 

@SuppressWarnings("serial")
@WebServlet(name = "SortedList", urlPatterns = {"/SortedList"})
public class SortedList extends HttpServlet {

    String homPath = "";
	
	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
                
                HttpSession session = request.getSession(true);
                try{
                    int sis = (int) session.getAttribute("SIS");
                    String type = request.getParameter("SortingType");
                    int sorting = 0;
                    if (type.equals("Comfort")){
                        sorting = (int) session.getAttribute("CardSortingStatus");
                    }
                    
                    ArrayList<Card> cards = (ArrayList<Card>) session.getAttribute("Cards");
                    if(sorting==2 && sis==1){
                        response.setContentType("application/json");
                        response.setCharacterEncoding("UTF-8");

                        PrintWriter writer = response.getWriter();
                        GsonBuilder builder = new GsonBuilder();
                        builder.setPrettyPrinting();
                        Gson gson = builder.create();
                        
                        String output = gson.toJson(cards);
                        writer.println(output);
                        writer.close();
                    }else{
                        response.setStatus(HttpServletResponse.SC_NOT_ACCEPTABLE);
                        response.setContentType("text/plain");
                        PrintWriter writer = response.getWriter();
                        writer.println("An error has occured.");
                        writer.close();
                    }

                }catch(Exception e){
                	Logger logger = Logger.getLogger(this.getClass().getName());
                    logger.log(Level.WARNING, e.getMessage());
                    
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    response.setContentType("text/plain");
                    PrintWriter writer = response.getWriter();
                    writer.println("An error has occured.");
                    writer.close();
                }
    }
	
}