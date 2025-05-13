// Tipos básicos
export type Nullable<T> = T | null;

// User Rol
export type UserRol = {
    id: number;
    name: string;
}

export type UserRolCreate = Pick<UserRol, 'name'>;

// Area
export type Area = {
    id: number;
    name: string;
}

export type AreaCreate = Pick<Area, 'name'>;

// User
export type User = {
    id: number;
    full_name: string;
    email: string;
    rol_id: number;
    area_id: number;
    hashed_password: string;
    rol?: UserRol;
    area?: Area;
}

export type UserCreate = Pick<User, 'full_name' | 'email' | 'rol_id' | 'area_id' | 'hashed_password'>;
export type UserUpdate = Partial<UserCreate>;

// Client Type
export type ClientType = {
    id: number;
    name: string;
}

export type ClientTypeCreate = Pick<ClientType, 'name'>;

// Business Turn
export type BusinessTurn = {
    id: number;
    name: string;
}

export type BusinessTurnCreate = Pick<BusinessTurn, 'name'>;

// Document
export type Document = {
    id: number;
    name: string;
    usages?: DocumentUsage[];
}

export type DocumentCreate = Pick<Document, 'name'>;

// Document Usage
export type DocumentUsage = {
    id: number;
    document_id: number;
    usage_type: 'legal_entity' | 'physical_person' | 'individual';
    document?: Document;
}

export type DocumentUsageCreate = Pick<DocumentUsage, 'document_id' | 'usage_type'>;

// Client
export type Client = {
    id: number;
    business_name: string;
    email?: string;
    phone_number?: string;
    tax_id?: string;
    type_id: number;
    turn_id?: number;
    created_at: string;
    updated_at: string;
    addresses?: ClientAddress[];
    documents?: ClientDocument[];
    brands?: Brand[];
    type?: ClientType;
    turn?: BusinessTurn;
}

export type ClientCreate = Pick<Client, 'business_name' | 'email' | 'phone_number' | 'tax_id' | 'type_id' | 'turn_id'>;
export type ClientUpdate = Partial<ClientCreate>;

// Client Address
export type ClientAddress = {
    id: number;
    client_id: number;
    street: string;
    city: string;
    state: string;
    postal_code: string;
    country: string;
    is_primary: boolean;
    client?: Client;
}

export type ClientAddressCreate = Pick<ClientAddress, 'client_id' | 'street' | 'city' | 'state' | 'postal_code' | 'country' | 'is_primary'>;
export type ClientAddressUpdate = Partial<ClientAddressCreate>;

// Client Document
export type ClientDocument = {
    id: number;
    client_id: number;
    document_id: number;
    file_path: string;
    uploaded_at: string;
    client?: Client;
    document?: Document;
}

export type ClientDocumentCreate = Pick<ClientDocument, 'client_id' | 'document_id' | 'file_path'>;

// Brand
export type Brand = {
    id: number;
    name: string;
    client_id: number;
    client?: Client;
    projects?: Project[];
}

export type BrandCreate = Pick<Brand, 'name' | 'client_id'>;
export type BrandUpdate = Partial<BrandCreate>;

// Individual
export type Individual = {
    id: number;
    full_name: string;
    tax_id?: string;
    created_at: string;
    updated_at: string;
    documents?: IndividualDocument[];
}

export type IndividualCreate = Pick<Individual, 'full_name' | 'tax_id'>;
export type IndividualUpdate = Partial<IndividualCreate>;

// Individual Document
export type IndividualDocument = {
    id: number;
    individual_id: number;
    document_id: number;
    file_path: string;
    uploaded_at: string;
    individual?: Individual;
    document?: Document;
}

export type IndividualDocumentCreate = Pick<IndividualDocument, 'individual_id' | 'document_id' | 'file_path'>;

// Residential Development
export type ResidentialDevelopment = {
    id: number;
    name: string;
    city: string;
    state: string;
    created_at: string;
    updated_at: string;
    lands?: Land[];
}

export type ResidentialDevelopmentCreate = Pick<ResidentialDevelopment, 'name' | 'city' | 'state'>;
export type ResidentialDevelopmentUpdate = Partial<ResidentialDevelopmentCreate>;

// Land
export type Land = {
    id: number;
    cadastral_file: string;
    area: number;
    build_area: number;
    price_per_area: number;
    address: string;
    residential_development_id: number;
    municipio?: string;
    valor_catastral?: number;
    pago_predial?: number;
    global_status?: number;
    name_last_update?: string;
    path_predial_file?: string;
    created_at: string;
    updated_at: string;
    residential_development?: ResidentialDevelopment;
    project_lands?: ProjectLand[];
}

export type LandCreate = Pick<Land, 'cadastral_file' | 'area' | 'build_area' | 'price_per_area' | 'address' | 'residential_development_id' | 'municipio' | 'valor_catastral' | 'pago_predial'>;
export type LandUpdate = Partial<LandCreate>;

// Stage
export type Stage = {
    id: number;
    name: string;
    description?: string;
    projects?: Project[];
}

export type StageCreate = Pick<Stage, 'name' | 'description'>;
export type StageUpdate = Partial<StageCreate>;

// Status
export type Status = {
    id: number;
    name: string;
    description?: string;
    projects?: Project[];
    lease_requests?: LeaseRequest[];
    cases?: Case[];
}

export type StatusCreate = Pick<Status, 'name' | 'description'>;
export type StatusUpdate = Partial<StatusCreate>;

// Project
export type Project = {
    id: number;
    name?: string;
    brand_id: number;
    stage_id: number;
    status_id: number;
    originator_id: number;
    created_at: string;
    updated_at: string;
    brand?: Brand;
    stage?: Stage;
    status?: Status;
    originator?: User;
    project_lands?: ProjectLand[];
    events?: ProjectEvent[];
    lease_requests?: LeaseRequest[];
    cases?: Case[];
    activities?: ProjectActivity[];
}

export type ProjectCreate = Pick<Project, 'name' | 'brand_id' | 'stage_id' | 'status_id' | 'originator_id'>;
export type ProjectUpdate = Partial<ProjectCreate>;

// Project Land Type
export type ProjectLandType = {
    id: number;
    name: string;
    description?: string;
    project_lands?: ProjectLand[];
}

export type ProjectLandTypeCreate = Pick<ProjectLandType, 'name' | 'description'>;
export type ProjectLandTypeUpdate = Partial<ProjectLandTypeCreate>;

// Project Land
export type ProjectLand = {
    id: number;
    project_id: number;
    land_id: number;
    area: number;
    type_id?: number;
    created_at: string;
    updated_at: string;
    project?: Project;
    land?: Land;
    type?: ProjectLandType;
}

export type ProjectLandCreate = Pick<ProjectLand, 'project_id' | 'land_id' | 'area' | 'type_id'>;
export type ProjectLandUpdate = Partial<ProjectLandCreate>;

// Project Event
export type ProjectEvent = {
    id: number;
    description: string;
    tentative_date: string;
    actual_date?: string;
    project_id: number;
    created_at: string;
    updated_at: string;
    project?: Project;
}

export type ProjectEventCreate = Pick<ProjectEvent, 'description' | 'tentative_date' | 'project_id'>;
export type ProjectEventUpdate = Partial<ProjectEventCreate>;

// Condition Category
export type ConditionCategory = {
    id: number;
    name: string;
    description?: string;
    conditions?: Condition[];
}

export type ConditionCategoryCreate = Pick<ConditionCategory, 'name' | 'description'>;
export type ConditionCategoryUpdate = Partial<ConditionCategoryCreate>;

// Condition Type
export type ConditionType = {
    id: number;
    name: string;
    description?: string;
    conditions?: Condition[];
}

export type ConditionTypeCreate = Pick<ConditionType, 'name' | 'description'>;
export type ConditionTypeUpdate = Partial<ConditionTypeCreate>;

// Condition
export type Condition = {
    id: number;
    name: string;
    description?: string;
    type_id: number;
    category_id: number;
    is_active: boolean;
    created_at: string;
    updated_at: string;
    type?: ConditionType;
    category?: ConditionCategory;
    options?: ConditionOption[];
    lease_request_conditions?: LeaseRequestCondition[];
    case_conditions?: CaseCondition[];
}

export type ConditionCreate = Pick<Condition, 'name' | 'type_id' | 'category_id' | 'description' | 'is_active'>;
export type ConditionUpdate = Partial<ConditionCreate>;

// Condition Option
export type ConditionOption = {
    id: number;
    condition_id: number;
    option_value: string;
    display_order: number;
    is_active: boolean;
    condition?: Condition;
}

export type ConditionOptionCreate = Pick<ConditionOption, 'condition_id' | 'option_value' | 'display_order' | 'is_active'>;
export type ConditionOptionUpdate = Partial<ConditionOptionCreate>;

// Guarantee Type
export type GuaranteeType = {
    id: number;
    name: string;
    description?: string;
    lease_requests?: LeaseRequest[];
}

export type GuaranteeTypeCreate = Pick<GuaranteeType, 'name' | 'description'>;
export type GuaranteeTypeUpdate = Partial<GuaranteeTypeCreate>;

// Owner
export type Owner = {
    id: number;
    name: string;
    description?: string;
    lease_requests?: LeaseRequest[];
}

export type OwnerCreate = Pick<Owner, 'name' | 'description'>;
export type OwnerUpdate = Partial<OwnerCreate>;

// Lease Request
export type LeaseRequest = {
    id: number;
    project_id: number;
    guarantee_id?: number;
    guarantee_type_id: number;
    owner_id: number;
    commission_agreement: boolean;
    assignment_income: boolean;
    property_file: string;
    created_at: string;
    updated_at: string;
    status_id: number;
    created_by: number;
    project?: Project;
    guarantee?: Individual;
    guarantee_type?: GuaranteeType;
    owner?: Owner;
    status?: Status;
    creator?: User;
    conditions?: LeaseRequestCondition[];
}

export type LeaseRequestCreate = Pick<LeaseRequest, 'project_id' | 'guarantee_id' | 'guarantee_type_id' | 'owner_id' | 'commission_agreement' | 'assignment_income' | 'property_file' | 'status_id' | 'created_by'>;
export type LeaseRequestUpdate = Partial<LeaseRequestCreate>;

// Lease Request Condition
export type LeaseRequestCondition = {
    id: number;
    lease_request_id: number;
    condition_id: number;
    text_value?: string;
    number_value?: number;
    date_value?: string;
    boolean_value?: boolean;
    option_id?: number;
    is_active: boolean;
    created_at: string;
    updated_at: string;
    lease_request?: LeaseRequest;
    condition?: Condition;
    option?: ConditionOption;
}

export type LeaseRequestConditionCreate = Pick<LeaseRequestCondition, 'lease_request_id' | 'condition_id' | 'text_value' | 'number_value' | 'date_value' | 'boolean_value' | 'option_id' | 'is_active'>;
export type LeaseRequestConditionUpdate = Partial<LeaseRequestConditionCreate>;

// Approval Flow
export type ApprovalFlow = {
    id: number;
    name: string;
    description?: string;
    is_active: boolean;
    steps?: ApprovalFlowStep[];
}

export type ApprovalFlowCreate = Pick<ApprovalFlow, 'name' | 'description' | 'is_active'>;
export type ApprovalFlowUpdate = Partial<ApprovalFlowCreate>;

// Approval Flow Step
export type ApprovalFlowStep = {
    id: number;
    flow_id: number;
    step_order: number;
    signator_role_id: number;
    signator_area_id?: number;
    is_required: boolean;
    flow?: ApprovalFlow;
    signator_role?: UserRol;
    signator_area?: Area;
    approval_requests?: ApprovalRequest[];
}

export type ApprovalFlowStepCreate = Pick<ApprovalFlowStep, 'flow_id' | 'step_order' | 'signator_role_id' | 'signator_area_id' | 'is_required'>;
export type ApprovalFlowStepUpdate = Partial<ApprovalFlowStepCreate>;

// Approval Request
export type ApprovalRequest = {
    id: number;
    flow_step_id: number;
    item_id: string;
    requested_by: number;
    requested_at: string;
    responded_at?: string;
    response?: boolean;
    comments?: string;
    flow_step?: ApprovalFlowStep;
    requester?: User;
}

export type ApprovalRequestCreate = Pick<ApprovalRequest, 'flow_step_id' | 'item_id' | 'requested_by'>;
export type ApprovalRequestUpdate = Partial<ApprovalRequestCreate>;

// Case Type
export type CaseType = {
    id: number;
    name: string;
    description?: string;
    cases?: Case[];
}

export type CaseTypeCreate = Pick<CaseType, 'name' | 'description'>;
export type CaseTypeUpdate = Partial<CaseTypeCreate>;

// Case
export type Case = {
    id: number;
    project_id: number;
    case_type_id: number;
    title: string;
    description?: string;
    originator_id: number;
    created_at: string;
    sended_at?: string;
    updated_at: string;
    status_id: number;
    project?: Project;
    case_type?: CaseType;
    originator?: User;
    status?: Status;
    conditions?: CaseCondition[];
}

export type CaseCreate = Pick<Case, 'project_id' | 'case_type_id' | 'title' | 'description' | 'originator_id' | 'status_id'>;
export type CaseUpdate = Partial<CaseCreate>;

// Case Condition
export type CaseCondition = {
    id: number;
    case_id: number;
    condition_id: number;
    text_value?: string;
    number_value?: number;
    date_value?: string;
    boolean_value?: boolean;
    option_id?: number;
    is_active: boolean;
    case?: Case;
    condition?: Condition;
    option?: ConditionOption;
}

export type CaseConditionCreate = Pick<CaseCondition, 'case_id' | 'condition_id' | 'text_value' | 'number_value' | 'date_value' | 'boolean_value' | 'option_id' | 'is_active'>;
export type CaseConditionUpdate = Partial<CaseConditionCreate>;

// Project Activity Status
export type ProjectActivityStatus = {
    id: number;
    name: string;
    description?: string;
    color_code?: string;
    activities?: ProjectActivity[];
}

export type ProjectActivityStatusCreate = Pick<ProjectActivityStatus, 'name' | 'description' | 'color_code'>;
export type ProjectActivityStatusUpdate = Partial<ProjectActivityStatusCreate>;

// Project Activity
export type ProjectActivity = {
    id: number;
    project_id: number;
    title: string;
    description?: string;
    responsible_area_id: number;
    responsible_id?: number;
    due_date: string;
    completed_date?: string;
    status_id: number;
    created_at: string;
    updated_at: string;
    created_by: number;
    project?: Project;
    responsible_area?: Area;
    responsible?: User;
    status?: ProjectActivityStatus;
    creator?: User;
}

export type ProjectActivityCreate = Pick<ProjectActivity, 'project_id' | 'title' | 'description' | 'responsible_area_id' | 'responsible_id' | 'due_date' | 'status_id' | 'created_by'>;
export type ProjectActivityUpdate = Partial<ProjectActivityCreate>;