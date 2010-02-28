class Visitor
  def homepage
    {:controller => :home}
  end

  def firstname
    ''
  end
  
  def lastname
    ''
  end

  def login
    'Visitor'
  end
  
  def role
    VisitorRole.new
  end
  
  def name
    'Guest'
  end
  
  def has_role?(role_)
    false
  end
  
  def superadmin?
    false
  end
  
  def admin?
    false
  end
  
  def friend?
    false
  end
  
  def user?
    false
  end

  def visitor?
    true
  end
  
  def self.authenticate(login, password)
  end

  def self.encrypt(password, salt)
  end

  def encrypt(password)
  end

  def authenticated?(password)
    true
  end

  def remember_token?
  end

  def remember_me
  end

  def forget_me
  end
end