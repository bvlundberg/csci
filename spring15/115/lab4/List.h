template<typename E> class List {
private:
   void operator =(const List&) {}  // Protect assignment
   List(const List&) {}    // Protect copy constructor
public:
   List() {}  // Default constructor
   virtual  ~List() {} // Base destructor

   // Clear contents from the list, freeing memory
   virtual void clear() = 0;

   // Insert an element at the beginning of the list.
   virtual void prepend(const E& item) = 0;

   // Append an element at the end of the list.
   virtual void append(const E& item) = 0;

   // Set the current position to the start of the list
   virtual void moveToStart() = 0;

   // Move the current position one step right, if possible;
   // return true if successful, false if already at the end
   virtual bool next() = 0;

   // Return the current element.
   virtual const E& getValue() const = 0;

   // Return total number of active nodes
   virtual int numActive() = 0;

   // Return total number of free nodes
   virtual int numFree() = 0;
};
