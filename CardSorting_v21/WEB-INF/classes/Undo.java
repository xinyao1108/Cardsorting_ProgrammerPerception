import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.google.gson.Gson; 
import com.google.gson.GsonBuilder; 

@SuppressWarnings("serial")
@WebServlet(name = "Undo", urlPatterns = {"/Undo"})
public class Undo extends HttpServlet {

    String homPath = "";

    /* protected void doGet(HttpServletRequest request,
        HttpServletResponse response) throws ServletException, IOException {
            HttpSession session = request.getSession(true);
    } */
	
	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
                
                HttpSession session = request.getSession(true);
                try{
                    int sis = (int) session.getAttribute("SIS");

                    String sortingType = request.getParameter("SortingType");
                    String attCurrentCard, attSortingState, attCardOrder;
                    if (sortingType.equals("Comfort")){
                        attCurrentCard = "CurrentCard";
                        attSortingState = "CardSortingStatus";
                        attCardOrder = "CardOrder";
                    }else{
                        response.setStatus(HttpServletResponse.SC_NOT_ACCEPTABLE);
                        response.setContentType("text/plain");
                        PrintWriter writer = response.getWriter();
                        writer.println("Invalid Request");
                        writer.close();
                        return;
                    }

                    int sorting = (int) session.getAttribute(attSortingState);
                    int orderIndex = (int) session.getAttribute(attCurrentCard);
                    ArrayList<Integer> order = (ArrayList<Integer>) session.getAttribute(attCardOrder);
                    ArrayList<Card> cards = (ArrayList<Card>) session.getAttribute("Cards");

                    if(sis == 1 && orderIndex > 0 && sorting == 0){
                        int cardIndex = order.get(orderIndex);
                        Card card = cards.get(cardIndex);
                        if(sortingType.equals("Comfort")){
                            card.setIsStartTime(false);
                        }
                        cards.set(cardIndex, card);
                        session.setAttribute("Cards",cards);

                        int prevOrderIndex = orderIndex-1;//moving to previous card
                        session.setAttribute(attCurrentCard, prevOrderIndex);
                        int prevCardIndex = order.get(prevOrderIndex);
                        Card prevCard = cards.get(prevCardIndex);

                        response.setContentType("application/json");
                        response.setCharacterEncoding("UTF-8");

                        PrintWriter writer = response.getWriter();
                        GsonBuilder builder = new GsonBuilder();
                        builder.setPrettyPrinting();
                        Gson gson = builder.create();
                        
                        String output = gson.toJson(prevCard);
                        writer.println(output);
                        writer.close();
                    }else if(sis == 1 && sorting == 1){
                        int prevOrderIndex = orderIndex-1;//moving to previous card
                        session.setAttribute(attCurrentCard, prevOrderIndex);
                        session.setAttribute(attSortingState, 0);
                        int prevCardIndex = order.get(prevOrderIndex);
                        Card prevCard = cards.get(prevCardIndex);

                        response.setContentType("application/json");
                        response.setCharacterEncoding("UTF-8");

                        PrintWriter writer = response.getWriter();
                        GsonBuilder builder = new GsonBuilder();
                        builder.setPrettyPrinting();
                        Gson gson = builder.create();
                        
                        String output = gson.toJson(prevCard);
                        writer.println(output);
                        writer.close();
                    }else if(sorting == 2){
                        response.setContentType("text/plain");
                        PrintWriter writer = response.getWriter();
                        writer.println("This acitivity is complete. You can't make any changes.");
                        writer.close();
                    }else{
                        response.setStatus(HttpServletResponse.SC_NOT_ACCEPTABLE);
                        response.setContentType("text/plain");
                        PrintWriter writer = response.getWriter();
                        writer.println("An error has occured.");
                        writer.close();
                    }

                }catch(Exception e){
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    response.setContentType("text/plain");
                    PrintWriter writer = response.getWriter();
                    writer.println("An error has occured.");
                    e.printStackTrace(writer);
                    writer.close();
                }
    }
	
}