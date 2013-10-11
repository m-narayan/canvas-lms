require File.expand_path(File.dirname(__FILE__) + '/spec_mt_helper')
require File.expand_path(File.dirname(__FILE__) + '/data_setup')


def ibm_course1_module1
  ibm_course1_module1 = ContextModule.find_by_name("Ibm course1 module1")
  if ibm_course1_module1 == nil
    ibm_course1_module1 = ibm_course1.context_modules.create!(:name => "Ibm course1 module1")
  end
  ibm_course1_module1
end

def ibm_course1_module2
  ibm_course1_module2 = ContextModule.find_by_name("Ibm course1 module2")
  if ibm_course1_module2 == nil
    ibm_course1_module2 = ibm_course1.context_modules.create!(:name => "Ibm course1 module2")
  end
  ibm_course1_module2
end

def ibm_course2_module1
  ibm_course2_module1 = ContextModule.find_by_name("Ibm course2 module1")
  if ibm_course2_module1 == nil
    ibm_course2_module1 = ibm_course2.context_modules.create!(:name => "Ibm course2 module1")
  end
  ibm_course2_module1
end

def ibm_course2_module2
  ibm_course2_module2 = ContextModule.find_by_name("Ibm course2 module2")
  if ibm_course2_module2 == nil
    ibm_course2_module2 = ibm_course2.context_modules.create!(:name => "Ibm course2 module2")
  end
  ibm_course2_module2
end

def ibm_course3_module1
  ibm_course3_module1 = ContextModule.find_by_name("Ibm course3 module1")
  if ibm_course3_module1 == nil
    ibm_course3_module1 = ibm_course3.context_modules.create!(:name => "Ibm course3 module1")
  end
  ibm_course3_module1
end

def ibm_course3_module2
  ibm_course3_module2 = ContextModule.find_by_name("Ibm course3 module2")
  if ibm_course3_module2 == nil
    ibm_course3_module2 = ibm_course3.context_modules.create!(:name => "Ibm course3 module2")
  end
  ibm_course3_module2
end



def ibm_course1_module1_assignment
  ibm_course1_module1_assignment=Assignment.find_by_title("Assignment for IBM course1 Module1")
  if ibm_course1_module1_assignment==nil
    ibm_course1_module1_assignment=ibm_course1.assignments.create(:title => "Assignment for IBM course1 Module1",:description=>"This is a test assignment description for IBM course1")
  end
  ibm_course1_module1_assignment
end

def ibm_course1_module2_assignment
  ibm_course1_module2_assignment=Assignment.find_by_title("Assignment for IBM course1 Module2")
  if ibm_course1_module2_assignment==nil
    ibm_course1_module2_assignment=ibm_course1.assignments.create(:title => "Assignment for IBM course1 Module2",:description=>"This is a test assignment description for IBM course1")
  end
  ibm_course1_module2_assignment
end

def ibm_course2_module1_assignment
  ibm_course2_module1_assignment=Assignment.find_by_title("Assignment for IBM course2 Module1")
  if ibm_course2_module1_assignment==nil
    ibm_course2_module1_assignment=ibm_course2.assignments.create(:title => "Assignment for IBM course2 Module1",:description=>"This is a test assignment description for IBM course2")
  end
  ibm_course2_module1_assignment
end

def ibm_course2_module2_assignment
  ibm_course2_module2_assignment=Assignment.find_by_title("Assignment for IBM course2 Module2")
  if ibm_course2_module2_assignment==nil
    ibm_course2_module2_assignment=ibm_course2.assignments.create(:title => "Assignment for IBM course2 Module2",:description=>"This is a test assignment description for IBM course2")
  end
  ibm_course2_module2_assignment
end

def ibm_course3_module1_assignment
  ibm_course3_module1_assignment=Assignment.find_by_title("Assignment for IBM course3 Module1")
  if ibm_course3_module1_assignment==nil
    ibm_course3_module1_assignment=ibm_course3.assignments.create(:title => "Assignment for IBM course3 Module1",:description=>"This is a test assignment description for IBM course3")
  end
  ibm_course3_module1_assignment
end

def ibm_course3_module2_assignment
  ibm_course3_module2_assignment=Assignment.find_by_title("Assignment for IBM course3 Module2")
  if ibm_course3_module2_assignment==nil
    ibm_course3_module2_assignment=ibm_course3.assignments.create(:title => "Assignment for IBM course3 Module2",:description=>"This is a test assignment description for IBM course3")
  end
  ibm_course3_module2_assignment
end



ibm_course1_module1.add_item({:id => ibm_course1_module1_assignment.id, :type => 'assignment'})
ibm_course1_module2.add_item({:id => ibm_course1_module2_assignment.id, :type => 'assignment'})

ibm_course2_module1.add_item({:id => ibm_course2_module1_assignment.id, :type => 'assignment'})
ibm_course2_module2.add_item({:id => ibm_course2_module2_assignment.id, :type => 'assignment'})

ibm_course3_module1.add_item({:id => ibm_course3_module1_assignment.id, :type => 'assignment'})
ibm_course3_module2.add_item({:id => ibm_course3_module2_assignment.id, :type => 'assignment'})




def tcs_course1_module1
  tcs_course1_module1 = ContextModule.find_by_name("Tcs course1 module1")
  if tcs_course1_module1 == nil
    tcs_course1_module1 = tcs_course1.context_modules.create!(:name => "Tcs course1 module1")
  end
  tcs_course1_module1
end

def tcs_course1_module2
  tcs_course1_module2 = ContextModule.find_by_name("Tcs course1 module2")
  if tcs_course1_module2 == nil
    tcs_course1_module2 = tcs_course1.context_modules.create!(:name => "Tcs course1 module2")
  end
  tcs_course1_module2
end

def tcs_course2_module1
  tcs_course2_module1 = ContextModule.find_by_name("Tcs course2 module1")
  if tcs_course2_module1 == nil
    tcs_course2_module1 = tcs_course2.context_modules.create!(:name => "Tcs course2 module1")
  end
  tcs_course2_module1
end

def tcs_course2_module2
  tcs_course2_module2 = ContextModule.find_by_name("Tcs course2 module2")
  if tcs_course2_module2 == nil
    tcs_course2_module2 = tcs_course2.context_modules.create!(:name => "Tcs course2 module2")
  end
  tcs_course2_module2
end

def tcs_course3_module1
  tcs_course3_module1 = ContextModule.find_by_name("Tcs course3 module1")
  if tcs_course3_module1 == nil
    tcs_course3_module1 = tcs_course3.context_modules.create!(:name => "Tcs course3 module1")
  end
  tcs_course3_module1
end

def tcs_course3_module2
  tcs_course3_module2 = ContextModule.find_by_name("Tcs course3 module2")
  if tcs_course3_module2 == nil
    tcs_course3_module2 = tcs_course3.context_modules.create!(:name => "Tcs course3 module2")
  end
  tcs_course3_module2
end


def tcs_course1_module1_assignment
  tcs_course1_module1_assignment=Assignment.find_by_title("Assignment for TCS course1 Module1")
  if tcs_course1_module1_assignment==nil
    tcs_course1_module1_assignment=tcs_course1.assignments.create(:title => "Assignment for TCS course1 Module1",:description=>"This is a test assignment description for TCS course1")
  end
  tcs_course1_module1_assignment
end

def tcs_course1_module2_assignment
  tcs_course1_module2_assignment=Assignment.find_by_title("Assignment for TCS course1 Module2")
  if tcs_course1_module2_assignment==nil
    tcs_course1_module2_assignment=tcs_course1.assignments.create(:title => "Assignment for TCS course1 Module2",:description=>"This is a test assignment description for TCS course1")
  end
  tcs_course1_module2_assignment
end

def tcs_course2_module1_assignment
  tcs_course2_module1_assignment=Assignment.find_by_title("Assignment for TCS course2 Module1")
  if tcs_course2_module1_assignment==nil
    tcs_course2_module1_assignment=tcs_course2.assignments.create(:title => "Assignment for TCS course2 Module1",:description=>"This is a test assignment description for TCS course2")
  end
  tcs_course2_module1_assignment
end

def tcs_course2_module2_assignment
  tcs_course2_module2_assignment=Assignment.find_by_title("Assignment for TCS course2 Module2")
  if tcs_course2_module2_assignment==nil
    tcs_course2_module2_assignment=tcs_course2.assignments.create(:title => "Assignment for TCS course2 Module2",:description=>"This is a test assignment description for TCS course2")
  end
  tcs_course2_module2_assignment
end

def tcs_course3_module1_assignment
  tcs_course3_module1_assignment=Assignment.find_by_title("Assignment for TCS course3 Module1")
  if tcs_course3_module1_assignment==nil
    tcs_course3_module1_assignment=tcs_course3.assignments.create(:title => "Assignment for TCS course3 Module1",:description=>"This is a test assignment description for TCS course3")
  end
  tcs_course3_module1_assignment
end

def tcs_course3_module2_assignment
  tcs_course3_module2_assignment=Assignment.find_by_title("Assignment for TCS course3 Module2")
  if tcs_course3_module2_assignment==nil
    tcs_course3_module2_assignment=tcs_course3.assignments.create(:title => "Assignment for TCS course3 Module2",:description=>"This is a test assignment description for TCS course3")
  end
  tcs_course3_module2_assignment
end




tcs_course1_module1.add_item({:id => tcs_course1_module1_assignment.id, :type => 'assignment'})
tcs_course1_module2.add_item({:id => tcs_course1_module2_assignment.id, :type => 'assignment'})

tcs_course2_module1.add_item({:id => tcs_course2_module1_assignment.id, :type => 'assignment'})
tcs_course2_module2.add_item({:id => tcs_course2_module2_assignment.id, :type => 'assignment'})

tcs_course3_module1.add_item({:id => tcs_course3_module1_assignment.id, :type => 'assignment'})
tcs_course3_module2.add_item({:id => tcs_course3_module2_assignment.id, :type => 'assignment'})



