# **Rick and Morty Character Explorer**  

A simple iOS application that fetches and displays characters from the **Rick and Morty API** using a **hybrid UIKit & SwiftUI approach**. The app implements **pagination**, **filtering**, and a **detailed character view**, all built without external dependencies or storyboards.  

## **App Preview**  

**Character List**
<div align="leading">
  <img src="https://github.com/user-attachments/assets/ab0f0da9-4a56-4f7e-9037-f30a51adfa93" alt="dashboard" width="200">
</div>

**Character Details**
<div align="leading">
  <img src="https://github.com/user-attachments/assets/be458b31-78fc-4aac-8ac0-863f88078553" alt="dashboard" width="200">
</div>

**App Functionality (GIF)**
<div align="leading">
  <img src="https://github.com/user-attachments/assets/175a9cde-bae7-40f3-8afc-22ba93e64469" alt="gif" width="200">
</div> 
---

## **Project Overview**  

This application is built following best practices in iOS development:  

- **SwiftUI for the character list** – Uses `List` for efficient rendering and pagination.  
- **UIKit for the details screen** – Integrated via `UIViewControllerRepresentable`.  
- **Fully programmatic UI** – No storyboards, XIBs, or external dependencies.  
- **Lightweight and maintainable architecture** – Clean separation of concerns for scalability.  

---

## **Features**  

### **Character List Screen**  

- Displays a paginated list (20 characters per page).  
- Includes character **name, image, and species**.  
- Implements a **status filter** (Alive, Dead, Unknown).  
- Uses SwiftUI's `List` for smooth scrolling and lazy loading.  

### **Character Details Screen**  

- Shows character **name, image, species, status, and gender**.  
- Built with UIKit and integrated into SwiftUI using `UIViewControllerRepresentable`.  
- Ensures smooth transitions and a flexible UI.
- 
### **Networking & State Management**  

- Uses **URLSession** for API calls.  
- Implements **protocol-oriented networking** for modularity.  
- Handles **loading states and errors** gracefully.  

## **Building and Running the Application**  

1. **Clone the repository:**  
   ```bash
   git clone https://github.com/yeniObabatunde/RickyAndMortyList.git
      cd your-project-folder
   ```  

2. **Open the project in Xcode:**  
   ```bash
   open RickAndMorty.xcodeproj
   ```  

3. **Run the application:**  
   - Ensure you have **Xcode 14 or later** installed.  
   - Select a **simulator or physical device**, then press `Cmd + R`.  
---
## **Assumptions & Design Decisions**  

- **SwiftUI for the list screen** – `List` is optimized for dynamic data.  
- **UIKit for character details** – Using `UIViewControllerRepresentable` allows easy UIKit-SwiftUI interoperability.  
- **Manual pagination** – The API provides paginated responses, so data is loaded in batches of 20.  
- **No external libraries** – Per the take-home assessment requirements.  
---
## **Challenges & Solutions**  

| **Challenge** | **Solution** |
|--------------|-------------|
| Integrating UIKit in SwiftUI | Used `UIViewControllerRepresentable` for seamless integration. |
| Implementing pagination in SwiftUI | Handled using `onAppear` to trigger new API requests. |
| Efficient Image Loading | Used `URLSession` and caching to optimize network usage. |
| Maintaining performance with filtering | Applied filtering locally to avoid redundant API calls. |
---

## **Testing**  

While optional, tests have been added for:  

- **ViewModels** – Ensuring correct state and data handling.  
- **Networking Layer** – Mocked API responses for unit testing.  

Run tests using:  
```bash
Cmd + U
```  
---

## **Future Improvements**  

- **Offline support** – Cache API responses for better UX.  
- **Refined UI** – Improve layout responsiveness across different screen sizes.  
- **Dark mode support** – Adjust UI for system-wide dark mode.  

---
