import { Condition, ProjectView } from "../types";

type getConditionRulesReturn = {
    value: string | boolean | undefined, 
    required: boolean | undefined
}

export const getConditionRules = (
    id: number, 
    conditions: Condition[], 
    project: ProjectView, 
    type: 'lease' | 'technical' = 'lease', 
    isChecked: boolean = false
) : getConditionRulesReturn => {
    // Create object
    const conditionResponse: getConditionRulesReturn = { value: undefined, required: undefined }

    let existsCondition = null

    // if exists items in the project response
    switch(type) {
        case 'lease':
            existsCondition = project?.lease_request?.conditions.find(c => c.condition_id === id)
            break;
        case 'technical':
            existsCondition = project?.technical_case?.conditions.find(c => c.condition_id === id)
            break;
    }

    // if exists, then return current value
    if(existsCondition) {
        if(isChecked){
            conditionResponse.value = existsCondition.is_active
        } else {
            conditionResponse.value = existsCondition.value
        }
    } else {
        // if it's not exists, there any rule?
        conditionResponse.value = rules(id, project)
    }

    return conditionResponse
}

const rules = (id: number, project: ProjectView) : string | undefined => {
    let value : string | undefined = undefined
    
    switch(id) {
        case 2:
            // Renta Mensual
            const price = project.lands.reduce((total, land) => total + (land.area * land.land.price_per_area), 0)
            value = price.toString()
            break;
        case 4:
            const pricePerArea = project.lands.reduce((total, land) => total + land.land.price_per_area, 0)
            value = pricePerArea.toString()
            break;
    }

    return value
}