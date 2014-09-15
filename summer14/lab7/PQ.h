class PQ{
private:
	string m_name;
	int m_size;
public:
	PQ(string name, int size){
		m_name = name;
		m_size = size-1;
	}
	~PQ(){

	}
	// Get Functions
	char getNameElem(int element){return m_name[element];}
	int getSize(){return m_size;}
	// Set Functions
	void swapElements(int element1, int element2){
		char temp = m_name[element1];
		m_name[element1] = m_name[element2];
		m_name[element2] = temp;
	}
	void setNameElem(char newElement, int element){
		m_name[element] = newElement;
	}
	void incrementSize(){m_size++;}
	void decrementSize(){m_size--;}
	// Other functions
	void swim(int element){
		while(element > 1){
			if(getNameElem(element) < getNameElem(element/2)){
				swapElements(element, element/2);
				element /= 2;
			}
		}
	}
	void sink(int element){
		while(element <= getSize()){
			if(getNameElem(element) > getNameElem(element*2) || getNameElem(element) > getNameElem(element*2 + 1)){
				if(getNameElem(element*2 + 1) < getNameElem(element*2)){
					swapElements(element,element*2 + 1);
					element = element*2 +1;
				}
				else{
					swapElements(element,element*2);
					element *= 2;
				}
			}
			else
				break;
		}
	}
	void insert(char newElement){
		incrementSize();
		setNameElem(newElement,getSize());
		swim(getSize());
	}
	char deleteMax(){
		char max = getNameElem(1);
		swapElements(1,getSize());
		decrementSize();
		sink(1);
		return max;
	}
	void printPQ(){
			cout << m_name;
	}
};