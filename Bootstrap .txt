import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;

@RestController
@RequestMapping("/credit-application")
public class CreditApplicationController {

    @Autowired
    private CreditApplicationService creditApplicationService;

    @PostMapping("/process")
    public String processFile() {
        try {
            creditApplicationService.processTextFile();
            return "Customer and credit application processed successfully";
        } catch (IOException e) {
            return "Error processing the file: " + e.getMessage();
        }
    }
}